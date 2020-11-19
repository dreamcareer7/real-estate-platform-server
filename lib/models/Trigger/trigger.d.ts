export interface ITriggerUpdateInput {
  user: UUID;

  event_type: string;
  wait_for?: number;
  time?: number;
  recurring?: boolean;

  brand_event?: UUID;
  campaign?: UUID;
}

export type ITriggerEndpointInput = {
  user: UUID;

  event_type: string;
  wait_for?: number;
  recurring?: boolean;

  contact?: UUID;
  deal?: UUID;
} & ( IEventAction | IEmailAction );

export interface ITriggerInput {
  created_by: UUID;
  brand: UUID;
  user: UUID;

  event_type: string;
  action: 'create_event' | 'schedule_email',
  wait_for?: number;
  time?: number;
  recurring?: boolean;

  flow?: UUID;
  flow_step?: UUID;

  brand_event?: UUID;
  campaign?: UUID;

  contact?: UUID;
  deal?: UUID;
}

interface IRawTriggerBase {
  created_by: UUID;
  brand: UUID;
  user: UUID;
  wait_for: number;
  time?: number;
  recurring: boolean;
}

type TContactEventTypes =
  | 'birthday'
  | 'work_anniversary'
  | 'wedding_anniversary'
  | 'home_anniversary'
  | 'child_birthday'
  ;

interface IContactTrigger {
  object_type: 'contact_attribute' | 'flow';
  trigger_object_type: 'contact';
  event_type: TContactEventTypes;
  contact: UUID;
}

type TDealEventTypes =
  | 'lease_application_date'
  | 'financing_due'
  | 't47_due'
  | 'title_due'
  | 'lease_begin'
  | 'expiration_date'
  | 'list_date'
  | 'recruit_other_agent'
  | 'option_period'
  | 'hoa_delivery'
  | 'lease_end'
  | 'inspection_date'
  | 'possession_date'
  | 'home_warranty_company'
  | 'lease_executed'
  | 'closing_date'
  | 'contract_date'
  ;

interface IDealTrigger {
  object_type: 'deal_context' | 'flow';
  trigger_object_type: 'deal';
  event_type: TDealEventTypes;
  deal: UUID;
}

interface IEventAction {
  action: 'create_event';
  brand_event: UUID;
}

type IEmailAction = {
  action: 'schedule_email';
  campaign: UUID;
}

type IFlowTrigger = {
  object_type: 'flow';
  event_type: 'flow_start';
  flow: UUID;
  flow_step: UUID;
} & ({
  trigger_object_type: 'deal';
  deal: UUID;
} | {
  trigger_object_type: 'contact';
  contact: UUID;
});

export type IRawTrigger = IRawTriggerBase & (IContactTrigger | IDealTrigger | IFlowTrigger) & (IEventAction | IEmailAction);

interface IModel {
  id: UUID;

  created_at: number;
  updated_at: number;
  deleted_at: number;

  created_by: UUID;
}

export type IStoredTrigger = IModel & IRawTrigger & {
  executed_at?: number;
  failed_at?: number;
  failure?: string;
};

export type IDueTrigger = IStoredTrigger & {
  timestamp: number;
  due_at: number;
}
