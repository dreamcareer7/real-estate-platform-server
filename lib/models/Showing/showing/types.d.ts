import { ShowingAppointment } from "../appointment/types";
import { ShowingAvailabilityInput, ShowingAvailabilityPopulated } from "../availability/types";
import { ShowingRole, ShowingRoleInput } from "../role/types";

interface StdAddr {

}

export type ApprovalType =
  | 'All'
  | 'Any'
  | 'None'
  ;

export interface Showing extends IModel {
  brand: UUID;
  aired_at?: number;
  start_date: string;
  end_date?: string;
  duration: number;
  notice_period?: number;
  approval_type: ApprovalType;
  feedback_template?: UUID;
  deal?: UUID;
  listing?: UUID;
  address?: StdAddr;
  gallery?: UUID;

  roles: UUID[];
  availabilities: UUID[];
  appointments: UUID[];
}

export interface ShowingPublic {
  id: UUID;
  start_date: string;
  end_date?: string;
  duration: number;
  notice_period?: number;
  agent: UUID;
  listing: UUID;
  unavailable_times: string[];
  availabilities: UUID[];
}

export interface ShowingPopulated extends IModel {
  brand: UUID;
  aired_at?: number;
  start_date: string;
  end_date?: string;
  duration: number;
  notice_period?: number;
  approval_type: ApprovalType;
  feedback_template?: UUID;
  deal?: UUID;
  listing?: UUID;
  address?: StdAddr;
  gallery?: UUID;

  roles: ShowingRole[];
  availabilities: ShowingAvailabilityPopulated[];
  appointments: ShowingAppointment[];
}

export interface ShowingInput {
  start_date: string;
  end_date?: string;
  duration: number;
  notice_period?: number;
  approval_type: ApprovalType;
  feedback_template?: UUID;
  deal?: UUID;
  listing?: UUID;
  address?: StdAddr;
  gallery?: UUID;

  roles: ShowingRoleInput[];
  availabilities: ShowingAvailabilityInput[];
}

export interface ShowingFilterOptions {
  deal?: UUID;
  listing?: UUID;
  live?: boolean;
}
