import { IStoredFlow } from "../types"

export interface IStoredFlowStep extends IModel {
  executed_at?: number;
  deleted_by: UUID;
  flow: UUID;
  origin: UUID;

  /** @todo this field was renamed from 'email' */
  campaign?: UUID;
  crm_task?: UUID;
}

export interface IFlowStepInput {
  created_by: UUID;
  flow: UUID;
  origin: UUID;
}

export interface IFailure <M extends IModel> {
  id: M['id'];
  message: string;
}

export type IFailedStep = IFailure<IStoredFlowStep>
export type IFailedFlow = IFailure<IStoredFlow>
