const syncMessagesPprojection = [
  'id', 'parentFolderId', 'conversationId',
  'internetMessageHeaders', 'internetMessageId',
  'createdDateTime', 'lastModifiedDateTime',
  'sender', 'from', 'toRecipients', 'ccRecipients', 'bccRecipients',
  'hasAttachments', 'subject', 'isDraft', 'isRead'
  // 'bodyPreview', 'uniqueBody', 'body'
]

const extractContactsProjection = [
  'id', 'createdDateTime', 'from', 'sender', 'toRecipients', 'ccRecipients', 'bccRecipients', 'subject', 'isDraft'
]

const wellKnownFolders = {
  beta: [
    'inbox', 'junkemail', 'archive', 'deleteditems', 'drafts', 'sentitems', 'outbox',
    'scheduled', 'searchfolders', 'serverfailures', 'syncissues', 'conversationhistory',
    'localfailures', 'recoverableitemsdeletions', 'msgfolderroot', 'clutter', 'conflicts'
  ],

  one: ['Archive', 'Conversation History', 'Deleted Items', 'Drafts', 'Inbox', 'Junk Email', 'Outbox', 'Sent Items']
}


module.exports = {
  syncMessagesPprojection,
  extractContactsProjection,
  wellKnownFolders
}