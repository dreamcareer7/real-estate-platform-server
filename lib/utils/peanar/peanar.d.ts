/* eslint-disable */

declare class PeanarJob {
  constructor(req: IPeanarRequest);
  perform(): Promise<any>;
}

export interface IPeanarJobDefinitionInput {
  queue: string;
  name?: string;
  routingKey?: string;
  exchange?: string;
  replyTo?: string;  
}

export interface IPeanarJobDefinition {
  name: string;
  queue: string;
  handler: (...args: any[]) => Promise<any>;

  routingKey: string;
  exchange?: string;
  replyTo?: string;
}

export interface IPeanarRequest {
  id: string;
  name: string;
  args: any[];
  correlationId?: string;
}

export interface IPeanarJob extends IPeanarJobDefinition, IPeanarRequest {}

export interface IPeanarOptions {
  jobClass: typeof PeanarJob;
  logger?(...args: any[]): any;
}
