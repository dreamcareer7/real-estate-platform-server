declare interface IUserBase {
  first_name: string;
  last_name: string;
  email_signature?: string;
  email: string;
  phone_number?: string;
  is_shadow: boolean;
  fake_email?: boolean;
  profile_image_url?: string;
  cover_image_url?: string;
  password?: string;
  last_seen_at?: number;
  user_type?: string;
}
declare interface IUserInput extends IUserBase {
  agent?: UUID;
  brand?: UUID;
  skip_confirmation?: boolean;

  user_connect?: UUID;
  room_connect?: UUID;
  actions?: string[];
}
declare interface IUser extends IModel, IUserBase {
    email_confirmed: boolean;
    phone_confirmed: boolean;
    timezone: string;

    secondary_password?: string;

    agent?: IAgent;

    display_name: string;
}

declare type TUserLogicalType =
  | 'RegisteredUser'
  | 'EmailShadowUser'
  | 'PhoneShadowUser'
  | 'Unknown';

declare type TUserSignupActions = 
  | 'create_alert'
  | 'listing_inquiry'
  | 'favorite_listing';

declare interface IUserActivationContext {
  agent?: UUID;
  action?: TUserSignupActions;
  alert?: UUID;
  listing?: UUID;
  room?: UUID;
}
