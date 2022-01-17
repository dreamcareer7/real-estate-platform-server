const sinon = require('sinon')
const proxyquire = require('proxyquire')
const { assert, expect } = require('chai')

const { stub } = sinon

const Orm = { enableAssociation: stub()  }
const Appointment = { get: stub() }
const Approval = { getAll: stub() }
const Showing = { get: stub() }
const Role = { getAll: stub() }
const db = { update: stub() }

const notification = {
  sendAppointmentConfirmedNotificationToBuyer: stub(),
  clearNotifications: stub(),
  sendGetFeedbackTextMessageToBuyer: stub(),
  sendAppointmentRejectedNotificationToBuyer: stub(),
  sendAppointmentCanceledNotificationToOtherRoles: stub(),
  sendAppointmentConfirmedNotificationToOtherRoles: stub(),
  sendAppointmentRejectedNotificationToOtherRoles: stub(),
}

const mailerFactory = {
  forGetFeedbackEmail: stub(),
  forConfirmedAppointment: stub(),
  forRejectedAppointment: stub(),
  forCanceledAppointmentAfterConfir: stub(),
}

const {
  utils,
  handlers,
  dispatchEvent
} = proxyquire('../../../lib/models/Showing/appointment/status_fsm', {
  '../../../utils/db': db,
  '../approval/get': Approval,
  '../appointment/get': Appointment,
  '../showing/get': Showing,
  '../role/get': Role,
  '../../Orm/context': Orm,
  './notification': notification,
  './mailer-factory': mailerFactory,
})

sinon.stub(utils)
sinon.stub(handlers)

const make = {
  approval: (id = 'appr', approved = false) => ({ id, approved }),
  appointment: (id = 'appt', status = 'OldStatus') => ({ id, status }),

  showing: (
    id = 'show',
    approval_type = 'All',
    roles = ['r1', 'r2']
  ) => ({ id, approval_type, roles }),
  
  payload: (
    action = 'FakeAction',
    showing = make.showing(),
    appointment = make.appointment(),
    approvals = [make.approval('appr1'), make.approval('appr2')]    
  ) => ({ action, showing, appointment, approvals }),

  approvalPayload: (...props) => make.payload('ApprovalPerformed', ...props),
}

const NOOP_MAILER = Object.freeze({ async send () { } })
describe('Showing/Appointment/status-fsm', () => {
  afterEach(() => sinon.reset())
  
  context('utils.everyoneApproved()', () => {
    context('returns false when...', () => {
      it('approvals are empty', () => {
        utils.everyoneApproved.callThrough()

        expect(utils.everyoneApproved([], [{}, {}])).to.be.false
      })

      it('roles are empty', () => {
        utils.everyoneApproved.callThrough()

        expect(utils.everyoneApproved([{}, {}], [])).to.be.false
      })

      it('there\'s no intersection between roles and approvals', () => {
        const roles = ['r1', 'r2']
        const approvals = [
          { approved: true, role: 'r3' },
          { approved: true, role: 'r4' },
        ]
        
        utils.everyoneApproved.callThrough()

        expect(utils.everyoneApproved(approvals, roles)).to.be.false
      })

      it('some roles reject', () => {
        const roles = ['r1', 'r2']
        const approvals = [
          { approved: true, role: 'r1' },
          { approved: false, role: 'r2' },
          { approved: true, role: 'r3' },
          { approved: true, role: 'r4' },
        ]
        
        utils.everyoneApproved.callThrough()

        expect(utils.everyoneApproved(approvals, roles)).to.be.false        
      })
      
      it('some roles have no approval', () => {
        const roles = ['r1', 'r2']
        const approvals = [
          { approved: true, role: 'r1' },
          { approved: true, role: 'r3' },
          { approved: true, role: 'r4' },
        ]
        
        utils.everyoneApproved.callThrough()

        expect(utils.everyoneApproved(approvals, roles)).to.be.false
      })
    })
    
    it('returns true when all roles confirmed', () => {
      const roles = ['r1', 'r2']
      const approvals = [
        { approved: true, role: 'r1' },
        { approved: true, role: 'r3' },
        { approved: false, role: 'r4' },
        { approved: true, role: 'r2' },
      ]
      
      utils.everyoneApproved.callThrough()

      expect(utils.everyoneApproved(approvals, roles)).to.be.true
    })
  })

  context('utils.findLatestApproval()', () => {
    function testFindLatest (approved) {
      const EXPECTED = { created_at: 10, updated_at: 10, approved }
      
      const approvals = [
        { created_at: 9, updated_at: 11, approved },
        EXPECTED,
        { created_at: 11, updated_at: 11, approved: !approved },
      ]

      utils.findLatestApproval.callThrough()

      expect(utils.findLatestApproval(approvals, approved)).to.be.equal(EXPECTED)
    }
    
    it('can find latest approved approval', () => {
      testFindLatest(true)
    })
    
    it('can find latest rejected approval', () => {
      testFindLatest(false)
    })
    
    it('returns nil when nothing found', () => {
      const allApproved = [
        { created_at: 1, updated_at: 1, approved: true },
        { created_at: 1, updated_at: 1, approved: true },
      ]

      const allRejected = [
        { created_at: 1, updated_at: 1, approved: false },
        { created_at: 1, updated_at: 1, approved: false },        
      ]
      
      utils.findLatestApproval.callThrough()

      expect(utils.findLatestApproval([], true)).to.be.undefined
      expect(utils.findLatestApproval([], true)).to.be.undefined
      expect(utils.findLatestApproval(allApproved, false)).to.be.undefined
      expect(utils.findLatestApproval(allRejected, true)).to.be.undefined
    })
  })

  context('utils.send()', () => {
    it('does nothing when mailer is nil', async () => {
      utils.send.callThrough()

      await utils.send(null)
      await utils.send(undefined)
      await utils.send(Promise.resolve(null))
      await utils.send(Promise.resolve(undefined))
    })
    
    it('calls send method after resolving non-nil mailer', async () => {
      const mailer = { send: sinon.fake() }

      utils.send.callThrough()
      await utils.send(Promise.resolve(mailer))

      assert(mailer.send.calledOnce)
    })
  })

  context('utils.patchStatus()', () => {
    // noop
  })

  context('handlers.finalized()', () => {
    it('populate all showing roles', async () => {
      const payload = make.payload()
      
      handlers.finalized.callThrough()
      Role.getAll.withArgs(payload.showing.roles).resolves([])
      
      await handlers.finalized(payload)

      assert(Role.getAll.calledOnceWithExactly(payload.showing.roles))
    })
    
    it('clears notifications of populated showing roles', async () => {
      const userIds = ['user1', 'user2']
      const roles = [
        { id: 'r1', user_id: userIds[0] },
        { id: 'r2', user_id: userIds[1] },
      ]
      
      const payload = make.payload()
      
      handlers.finalized.callThrough()
      Role.getAll.withArgs(payload.showing.roles).resolves(roles)
      
      await handlers.finalized(payload)

      expect(notification.clearNotifications.callCount).to.be.equal(roles.length)
      assert(notification.clearNotifications.alwaysCalledWithMatch(
        sinon.match.in(userIds),
        payload.appointment.id
      ))
    })
  })

  context('handlers.completed()', () => {
    it('sends get-feedback sms & email to buyer', async () => {
      const payload = make.payload()
      
      handlers.completed.callThrough()

      await handlers.completed(payload)

      assert(notification.sendGetFeedbackTextMessageToBuyer
        .calledOnceWithExactly(payload.appointment.id))
      assert(mailerFactory.forGetFeedbackEmail
        .calledOnceWithExactly(payload.appointment))
    })
  })

  context('handlers.confirmed()', () => {
    it('calls utils.approvalNotFound if no confirmed approval found', async () => {
      const payload = make.payload()

      utils.findLatestApproval.withArgs(payload, true).returns(undefined)
      handlers.confirmed.callThrough()

      await handlers.confirmed(payload)

      assert(utils.approvalNotFound.calledOnce)
      assert(utils.send.notCalled)
      assert(mailerFactory.forConfirmedAppointment.notCalled)
      assert(notification.sendAppointmentConfirmedNotificationToBuyer.notCalled)
      assert(
        notification.sendAppointmentConfirmedNotificationToOtherRoles.notCalled
      )
    })
    
    it('sends suitable notifs to roles and buyer', async () => {
      const payload = make.payload()
      const appt = payload.appointment
      const appr = payload.approvals[0]
      
      utils.findLatestApproval
        .withArgs(payload.approvals, true).returns(appr)
      handlers.confirmed.callThrough()

      await handlers.confirmed(payload)

      assert(utils.approvalNotFound.notCalled)
      assert(utils.send.calledOnce)
      assert(mailerFactory.forConfirmedAppointment.calledOnceWithExactly(appt))
      assert(
        notification.sendAppointmentConfirmedNotificationToBuyer
          .calledOnceWithExactly(appt.id)
      )
      assert(
        notification.sendAppointmentConfirmedNotificationToOtherRoles
          .calledOnceWithExactly(appt.id, appr.role)
      )
    })
  })

  context('handlers.rejected()', () => {
    it('calls utils.approvalNotFound if no rejected approval found', async () => {
      const payload = make.payload()

      utils.findLatestApproval.withArgs(payload, false).returns(undefined)
      handlers.rejected.callThrough()

      await handlers.rejected(payload)

      assert(utils.approvalNotFound.calledOnce)
      assert(utils.send.notCalled)
      assert(mailerFactory.forRejectedAppointment.notCalled)
      assert(notification.sendAppointmentRejectedNotificationToBuyer.notCalled)
      assert(notification.sendAppointmentRejectedNotificationToOtherRoles.notCalled)
    })
    
    it('sends appointment-rejected sms & email to buyer')
    it('sends rejection notif to other roles')
  })

  context('handlers.canceledAfterConfirm()', () => {
    it('sends appointment-canceled sms & email to buyer')
    it('sends cancelation notif to other roles')
  })

  context('handlers.autoConfirmed()', () => {
    it('sends appointment-auto-confirmed sms & email to buyer')
    it('sends auto-confirmation notif to roles')
  })

  context('handlers.requested()', () => {
    it('sends appointment-requested sms & email to buyer')
    it('sends request notif to roles')
  })

  context('handlers.buyerCanceled()', () => {
    it('sends appointment-canceled sms & email to buyer')
    it('sends cancel notif to roles')
  })

  context('handlers.gaveFeedback()', () => {
    it('sends feedback-received sms & email to buyer')
    it('sends feedback notif to roles')
  })

  context('handlers.rescheduled()', () => {
    it('sends appointment-rescheduled sms & email to buyer')
    it('sends rescheduled notif to roles')
  })

  context('utils.guessNewStatus()', () => {
    it('maps simple actions to their related appointment status', () => {
      const payload = make.payload()
      
      utils.guessNewStatus.callThrough()
      
      payload.action = 'BuyerCanceled'
      expect(utils.guessNewStatus(payload)).to.be.equal('Canceled')

      payload.action = 'Rescheduled'
      expect(utils.guessNewStatus(payload)).to.be.equal('Rescheduled')      
    })
    
    it('returns Completed/Canceled for Finished based on old status', () => {
      const payload = make.payload('Finished')
      
      utils.guessNewStatus.callThrough()

      payload.appointment.status = 'Confirmed'
      expect(utils.guessNewStatus(payload)).to.be.equal('Completed')

      payload.appointment.status = 'NotConfirmed'
      expect(utils.guessNewStatus(payload)).to.be.equal('Canceled')
    })

    it('returns Confirmed for an rescheduled appt. that needs no approval', () => {
      const payload = make.payload('Rescheduled')

      utils.guessNewStatus.callThrough()

      payload.showing.approval_type = 'None'
      expect(utils.guessNewStatus(payload)).to.be.equal('Confirmed')
    })

    context('when an approval is performed returns...', () => {
      it('Canceled if someone rejected', () => {
        const payload = make.approvalPayload()

        utils.guessNewStatus.callThrough()

        expect(utils.guessNewStatus(payload)).to.be.equal('Canceled')
      })
      
      it('Confirmed if approval type is None', () => {
        const payload = make.approvalPayload()
        payload.approvals.forEach(a => { a.approved = true })
        payload.showing.approval_type = 'None'

        utils.guessNewStatus.callThrough()

        expect(utils.guessNewStatus(payload)).to.be.equal('Confirmed')
      })
      
      it('Requested when approvals is empty', () => {
        const payload = make.approvalPayload()
        payload.approvals.forEach(a => { a.approved = true })
        payload.approvals = []

        utils.guessNewStatus.callThrough()

        expect(utils.guessNewStatus(payload)).to.be.equal('Requested')
      })
      
      it('Confirmed if someone confirmed and approval type is Any', () => {
        const payload = make.approvalPayload()
        payload.showing.approval_type = 'Any'
        payload.approvals = [make.approval('confirmed-approval', true)]

        utils.guessNewStatus.callThrough()

        expect(utils.guessNewStatus(payload)).to.be.equal('Confirmed')
      })
      
      it('Confirmed if all roles confirmed and approval type is All', () => {
        const payload = make.approvalPayload()
        payload.showing.roles = ['r1', 'r2']
        payload.approvals.forEach(a => { a.approved = true })

        utils.everyoneApproved
          .withArgs(payload.approvals, payload.showing.roles)
          .returns(true)
        utils.guessNewStatus.callThrough()

        const newStatus = utils.guessNewStatus(payload)
        
        assert(utils.everyoneApproved.calledOnce)
        expect(newStatus).to.be.equal('Confirmed')
      })
      
      it('old status if action is not handled', () => {
        const payload = make.payload('MissingAction')

        utils.guessNewStatus.callThrough()

        expect(utils.guessNewStatus(payload))
          .to.be.equal(payload.appointment.status)
      })
    })
  })

  context('handlers.handleAction()', () => {
    it('does not patchStatus if status is not changed', async () => {
      const payload = make.payload()

      utils.guessNewStatus.withArgs(payload).returns(payload.appointment.status)
      handlers.handleAction.callThrough()

      await handlers.handleAction(payload)
      
      assert(utils.guessNewStatus.calledOnceWithExactly(payload))
      assert(utils.validateTransition.calledOnce)
      assert(utils.patchStatus.notCalled)
    })
    
    it('calls handlers.completed if new status is Completed', async () => {
      const payload = make.payload()

      utils.guessNewStatus.withArgs(payload).returns('Completed')
      handlers.handleAction.callThrough()
      
      await handlers.handleAction(payload)

      assert(utils.validateTransition.calledOnce)
      assert(utils.patchStatus.calledOnce)
      assert(handlers.completed.calledOnceWithExactly(payload))
    })
    
    it('calls handlers.finalized if new status is Completed or Canceled', async () => {
      const payload = make.payload()

      handlers.handleAction.callThrough()
      
      for (const finalStatus of ['Completed', 'Canceled']) {
        utils.guessNewStatus.withArgs(payload).returns(finalStatus)

        await handlers.handleAction(payload)

        assert(utils.validateTransition.calledOnce)
        assert(utils.patchStatus.calledOnce)
        assert(handlers.finalized.calledOnceWithExactly(payload))

        utils.validateTransition.reset()
        utils.patchStatus.reset()
        handlers.finalized.reset()
      }
    })
    
    it('calls utils.patchStatus w/ appointment ID and newStatus', async () => {
      const payload = make.payload()
      const appt = payload.appointment
      const newStatus = 'NewStatus'

      utils.guessNewStatus.withArgs(payload).returns(newStatus)
      handlers.handleAction.callThrough()

      await handlers.handleAction(payload)

      assert(utils.validateTransition.calledOnceWithExactly(
        appt.status, newStatus
      ))

      assert(utils.patchStatus.calledOnceWithExactly(appt.id, newStatus))
    })


    it('calls handlers.autoConfirmed when a rescheduled appt is auto confirmed', async () => {
      const payload = make.payload('Rescheduled')

      utils.guessNewStatus.withArgs(payload).returns('Confirmed')
      handlers.handleAction.callThrough()

      await handlers.handleAction(payload)

      assert(handlers.autoConfirmed.calledOnce)
    })

    it('calls handlers.rescheduled when the appt is gonna be rescheduled')

    context('when an approval is performed...', () => {
      async function testApproval (oldStatus, newStatus, handler) {
        const payload = make.approvalPayload()
        payload.appointment.status = oldStatus

        utils.guessNewStatus.withArgs(payload).returns(newStatus)
        handlers.handleAction.callThrough()

        await handlers.handleAction(payload)

        assert(handlers[handler].calledOnceWithExactly(payload))

        sinon.reset()
      }
      
      it('calls handlers.confirmed if new status is Confirmed', async () => {
        await testApproval('AnyStatus', 'Confirmed', 'confirmed')
      })
      
      it('calls handlers.rejected if it was a rejection', async () => {
        await testApproval('Requested', 'Canceled', 'rejected')
        await testApproval('Rescheduled', 'Canceled', 'rejected')
      })
      
      it('calls handlers.canceledAfterConfirm if it was a cancelation', async () => {
        await testApproval('Confirmed', 'Canceled', 'canceledAfterConfirm')
      })
    })

    context('when buyer gives feedback...', () => {
      it('calls handlers.gaveFeedback')
    })

    context('when an appt is requested...', () => {
      it('calls handlers.autoConfirmed if the status gonna be Confirmed')
      it('calls handlers.requested if the status gonna be Requested')
    })
  })

  context('.dispatchEvent()', () => {
    it('calls handlers.handleAction w/ populated payload', async () => {
      const action = 'InvalidAction'
      const apptId = 'foo'
      const appointment = { showing: 'bar', approvals: ['baz', 'qux'] }
      const showing = { id: 'quux' }
      const approvals = [{ id: 'nux' }]

      Appointment.get.withArgs(apptId).resolves(appointment)
      Showing.get.withArgs(appointment.showing).resolves(showing)
      Approval.getAll.withArgs(appointment.approvals).resolves(approvals)
      
      await dispatchEvent(action, apptId)

      assert(handlers.handleAction.calledOnce)

      const payload = handlers.handleAction.firstCall.firstArg

      expect(payload).to.be.an('object')
        .that.includes({ action, appointment, showing, approvals })
    })
  })
})
