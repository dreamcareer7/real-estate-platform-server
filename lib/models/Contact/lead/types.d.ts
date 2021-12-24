export interface ILtsLead {
  note: string;
  first_name: string;
  last_name: string;
  email: string;
  phone_number: string;
  company: string;
  address: string;
  message: string;
  tag: string | string[];
  owner_id: string;
  lead_source: string;
  lead_source_url: string;
  lead_subsource: string;
  listing_number: string;
  agent_mlsid: string;
  office_mlsid: string;
}

export type ELeadSourceType =
  | 'Website'
  | 'Zillow'
  | 'Realtor'
  | 'Showing'
  | 'Studio'
  ;

export interface ILtsLeadUrlMetadata {
  brand: UUID;
  user: UUID;
  protocol: TLeadProtocol;
  mls?: string[];
  source?: ELeadSourceType;
  notify?: boolean;
}
