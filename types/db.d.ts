declare type TDbSqlAddress =
  | 'activity/get'
  | 'activity/record'
  | 'activity/timeline'
  | 'address/batch_latlong_bing'
  | 'address/batch_latlong_google'
  | 'address/create'
  | 'address/fix_missing'
  | 'address/get'
  | 'address/map_to_listing'
  | 'address/mark_as_corrupted'
  | 'address/mark_as_corrupted_bing'
  | 'address/mark_as_corrupted_google'
  | 'address/update_latlong'
  | 'address/update_latlong_bing'
  | 'address/update_latlong_google'
  | 'address/update_latlong_mapbox'
  | 'address/update_latlong_mls'
  | 'agent/get'
  | 'agent/get_mlsid'
  | 'agent/insert'
  | 'agent/match_by_email'
  | 'agent/office_mls'
  | 'agent/refresh_emails'
  | 'agent/refresh_phones'
  | 'agent/report'
  | 'agent/search'
  | 'alert/delete'
  | 'alert/get'
  | 'alert/insert'
  | 'alert/patch'
  | 'alert/remove_recs_refs'
  | 'alert/room'
  | 'alert/search'
  | 'alert/user'
  | 'billing_plan/get-by-chargebee-id'
  | 'billing_plan/get-publics'
  | 'billing_plan/get'
  | 'billing_plan/set'
  | 'brand/agents'
  | 'brand/asset/by-brand'
  | 'brand/asset/delete'
  | 'brand/asset/get'
  | 'brand/asset/insert'
  | 'brand/by_parent'
  | 'brand/checklist/by_brand'
  | 'brand/checklist/get'
  | 'brand/checklist/insert'
  | 'brand/checklist/remove'
  | 'brand/checklist/task/delete'
  | 'brand/checklist/task/insert'
  | 'brand/checklist/task/sort'
  | 'brand/checklist/task/update'
  | 'brand/checklist/update'
  | 'brand/context/by-brand'
  | 'brand/context/delete'
  | 'brand/context/get'
  | 'brand/context/insert'
  | 'brand/context/set-checklists'
  | 'brand/context/sort'
  | 'brand/context/update'
  | 'brand/customer/by-brand'
  | 'brand/customer/get'
  | 'brand/customer/set'
  | 'brand/customer/update'
  | 'brand/deal/property_type/by-brand'
  | 'brand/deal/property_type/get'
  | 'brand/deal/property_type/insert'
  | 'brand/deal/property_type/remove'
  | 'brand/deal/property_type/sort'
  | 'brand/deal/property_type/update'
  | 'brand/deal/status/by-brand'
  | 'brand/deal/status/delete'
  | 'brand/deal/status/get'
  | 'brand/deal/status/insert'
  | 'brand/deal/status/update'
  | 'brand/default/get'
  | 'brand/default/set'
  | 'brand/delete'
  | 'brand/email/by_brand'
  | 'brand/email/get'
  | 'brand/email/insert'
  | 'brand/email/remove'
  | 'brand/email/update'
  | 'brand/event/by_brand'
  | 'brand/event/create'
  | 'brand/event/delete'
  | 'brand/event/get'
  | 'brand/event/update'
  | 'brand/flow/create'
  | 'brand/flow/delete'
  | 'brand/flow/for_brand'
  | 'brand/flow/get'
  | 'brand/flow/has_access'
  | 'brand/flow/step/create'
  | 'brand/flow/step/delete'
  | 'brand/flow/step/get'
  | 'brand/flow/step/update'
  | 'brand/flow/step/update_flow_step_orders'
  | 'brand/flow/update'
  | 'brand/get'
  | 'brand/get_parents'
  | 'brand/get_user_brands'
  | 'brand/hostname/add'
  | 'brand/hostname/get'
  | 'brand/hostname/remove'
  | 'brand/insert'
  | 'brand/is_sub_member'
  | 'brand/is_training'
  | 'brand/list/create'
  | 'brand/list/for_brand'
  | 'brand/list/get'
  | 'brand/propose'
  | 'brand/role/by_brand'
  | 'brand/role/by_user'
  | 'brand/role/delete'
  | 'brand/role/get'
  | 'brand/role/insert'
  | 'brand/role/member/add'
  | 'brand/role/member/by_role'
  | 'brand/role/member/get'
  | 'brand/role/member/remove'
  | 'brand/role/update'
  | 'brand/settings/get'
  | 'brand/settings/set'
  | 'brand/subscription/by-brand'
  | 'brand/subscription/get-quantity'
  | 'brand/subscription/get'
  | 'brand/subscription/insert'
  | 'brand/subscription/update'
  | 'brand/template/by-form'
  | 'brand/template/delete'
  | 'brand/template/get'
  | 'brand/template/insert'
  | 'brand/update'
  | 'brand/webhook/find'
  | 'brand/webhook/get'
  | 'brand/webhook/insert'
  | 'brokerwolf/classifications/get-id'
  | 'brokerwolf/classifications/insert'
  | 'brokerwolf/classifications/map'
  | 'brokerwolf/contact-types/get-id'
  | 'brokerwolf/contact-types/insert'
  | 'brokerwolf/contact-types/map'
  | 'brokerwolf/members/boards/insert'
  | 'brokerwolf/members/insert'
  | 'brokerwolf/property-types/get-id'
  | 'brokerwolf/property-types/insert'
  | 'brokerwolf/property-types/map'
  | 'brokerwolf/settings/by-brand'
  | 'brokerwolf/settings/save'
  | 'calendar/create_feed_setting'
  | 'calendar/get_feed_setting'
  | 'calendar/notification/calendar_events_notification_settings'
  | 'calendar/notification/calendar_notification_settings'
  | 'calendar/notification/clean_global'
  | 'calendar/notification/create_log'
  | 'calendar/notification/get_global'
  | 'calendar/notification/now'
  | 'calendar/notification/unread'
  | 'calendar_integration/delete'
  | 'calendar_integration/get'
  | 'calendar_integration/get_by_contact_attributes'
  | 'calendar_integration/get_by_contacts'
  | 'calendar_integration/get_by_crm_tasks'
  | 'calendar_integration/get_by_deal_contexts'
  | 'calendar_integration/get_by_google_ids'
  | 'calendar_integration/get_by_home_anniversaries'
  | 'calendar_integration/get_by_microsoft_ids'
  | 'calendar_integration/insert'
  | 'calendar_integration/reset_etag_by_crm_task'
  | 'calendar_integration/reset_etag_by_crm_task_and_origin'
  | 'client/default'
  | 'client/get'
  | 'contact/access/get_user_brands'
  | 'contact/attribute/clear_primaries'
  | 'contact/attribute/delete'
  | 'contact/attribute/for_contacts'
  | 'contact/attribute/get'
  | 'contact/attribute_def/create'
  | 'contact/attribute_def/delete'
  | 'contact/attribute_def/for_brand'
  | 'contact/attribute_def/get'
  | 'contact/attribute_def/globals'
  | 'contact/attribute_def/has_access'
  | 'contact/attribute_def/update'
  | 'contact/authorized_brands'
  | 'contact/delete'
  | 'contact/duplicate/add'
  | 'contact/duplicate/for_contact'
  | 'contact/duplicate/get'
  | 'contact/duplicate/ignore'
  | 'contact/duplicate/ignore_all'
  | 'contact/duplicate/ignore_cluster'
  | 'contact/duplicate/ignored_after'
  | 'contact/duplicate/remove/disband_clusters'
  | 'contact/duplicate/remove/remove_clusters_for_brand'
  | 'contact/duplicate/remove/remove_clusters_for_contacts'
  | 'contact/duplicate/remove/remove_pairs_for_brand'
  | 'contact/duplicate/remove/remove_pairs_for_contacts'
  | 'contact/duplicate/remove'
  | 'contact/duplicate/unignore_after'
  | 'contact/duplicate/update'
  | 'contact/duplicate/update_duplicate_clusters_for_brand'
  | 'contact/duplicate/update_duplicate_clusters_for_contacts'
  | 'contact/duplicate/update_duplicate_pairs_for_brand'
  | 'contact/email/update'
  | 'contact/export/max_indices'
  | 'contact/get'
  | 'contact/has_access'
  | 'contact/lead/save'
  | 'contact/list/create'
  | 'contact/list/create_default_lists'
  | 'contact/list/delete'
  | 'contact/list/get'
  | 'contact/list/has_access'
  | 'contact/list/list_for_brands'
  | 'contact/list/update'
  | 'contact/list_member/delete_contact'
  | 'contact/list_member/delete_list'
  | 'contact/list_member/find_by_contact_ids'
  | 'contact/list_member/find_by_list_id'
  | 'contact/list_member/get'
  | 'contact/list_member/table'
  | 'contact/merge'
  | 'contact/set_updated_at'
  | 'contact/summary/get'
  | 'contact/tag/create'
  | 'contact/tag/delete'
  | 'contact/tag/disable_auto_enroll_in_super_campaigns'
  | 'contact/tag/enable_auto_enroll_in_super_campaigns'
  | 'contact/tag/get'
  | 'contact/tag/recreate'
  | 'contact/tag/rename'
  | 'contact/tag/support_delete_all'
  | 'contact/tag/update_touch_freq'
  | 'contact/timeline'
  | 'contact/undelete'
  | 'contact/update_display_names'
  | 'contact/update_searchable_field'
  | 'contact/update_summary'
  | 'contact_integration/delete'
  | 'contact_integration/get'
  | 'contact_integration/get_by_contacts'
  | 'contact_integration/get_by_google_ids'
  | 'contact_integration/get_by_microsoft_ids'
  | 'contact_integration/hard_delete'
  | 'contact_integration/insert'
  | 'contact_integration/reset_etag_by_contact'
  | 'contact_integration/reset_etag_by_contact_and_origin'
  | 'contact_integration/restore'
  | 'crm/associations/delete'
  | 'crm/associations/get'
  | 'crm/associations/get_for_task'
  | 'crm/associations/insert'
  | 'crm/associations/table'
  | 'crm/associations/update'
  | 'crm/reminder/delete'
  | 'crm/reminder/delete_many'
  | 'crm/reminder/get'
  | 'crm/reminder/insert'
  | 'crm/reminder/now'
  | 'crm/reminder/patch_notification'
  | 'crm/reminder/table'
  | 'crm/reminder/update'
  | 'crm/reminder/update_many'
  | 'crm/task/assignee/delete'
  | 'crm/task/assignee/get_by_task'
  | 'crm/task/assignee/get_by_user'
  | 'crm/task/delete'
  | 'crm/task/get'
  | 'crm/task/has_access'
  | 'crm/task/insert'
  | 'crm/task/now'
  | 'crm/task/patch_notification'
  | 'crm/task/table'
  | 'crm/task/unread'
  | 'crm/task/update'
  | 'crm/task/update_many'
  | 'crm/touch/increase_touch_times_for_contacts'
  | 'crm/touch/update_touch_times_for_contacts'
  | 'daily/due'
  | 'daily/get'
  | 'daily/save'
  | 'daily/set-email'
  | 'deal/brand'
  | 'deal/brand_inbox'
  | 'deal/brokerwolf/set'
  | 'deal/by-number'
  | 'deal/by_room'
  | 'deal/checklist/get'
  | 'deal/checklist/insert'
  | 'deal/checklist/sort'
  | 'deal/checklist/update'
  | 'deal/context/get'
  | 'deal/context/history'
  | 'deal/context/insert'
  | 'deal/context/set_approved'
  | 'deal/delete'
  | 'deal/get'
  | 'deal/has-access'
  | 'deal/insert'
  | 'deal/role/add'
  | 'deal/role/get'
  | 'deal/role/remove'
  | 'deal/role/update'
  | 'deal/update'
  | 'deal/user'
  | 'email/campaign/attachments/delete_by_campaing'
  | 'email/campaign/attachments/get'
  | 'email/campaign/attachments/get_by_campaing'
  | 'email/campaign/attachments/insert'
  | 'email/campaign/by_brand'
  | 'email/campaign/by_user'
  | 'email/campaign/check_quota'
  | 'email/campaign/delete'
  | 'email/campaign/due'
  | 'email/campaign/email/error'
  | 'email/campaign/email/find'
  | 'email/campaign/email/get'
  | 'email/campaign/email/get_by_emails'
  | 'email/campaign/emails'
  | 'email/campaign/find-domain'
  | 'email/campaign/get'
  | 'email/campaign/insert'
  | 'email/campaign/lock'
  | 'email/campaign/mark-as-executed'
  | 'email/campaign/notifications_enabled'
  | 'email/campaign/recipient/get'
  | 'email/campaign/recipient/insert'
  | 'email/campaign/save-error'
  | 'email/campaign/save_thread_key'
  | 'email/campaign/schedule_at'
  | 'email/campaign/update-stats'
  | 'email/campaign/update'
  | 'email/event/get'
  | 'email/event/mailgun_add'
  | 'email/event/rechat_add'
  | 'email/get'
  | 'email/get_by_google_message_id'
  | 'email/get_by_mailgun_id'
  | 'email/get_by_microsoft_message_id'
  | 'email/store-id'
  | 'email/store_google_id'
  | 'email/store_microsoft_id'
  | 'email/super_campaign/by_brand'
  | 'email/super_campaign/delete'
  | 'email/super_campaign/due'
  | 'email/super_campaign/eligible_agents'
  | 'email/super_campaign/eligible_brands'
  | 'email/super_campaign/enrollment/delete_by'
  | 'email/super_campaign/enrollment/get'
  | 'email/super_campaign/enrollment/hard_delete_by'
  | 'email/super_campaign/enrollment/mark_as_forked'
  | 'email/super_campaign/enrollment/opt_out'
  | 'email/super_campaign/enrollment/synchronize_tags'
  | 'email/super_campaign/enrollment/table'
  | 'email/super_campaign/enrollment/unionize_tags'
  | 'email/super_campaign/enrollment/update'
  | 'email/super_campaign/enrollment/update_campaigns'
  | 'email/super_campaign/enrollment/upsert_many'
  | 'email/super_campaign/enrollment/patch'
  | 'email/super_campaign/get'
  | 'email/super_campaign/insert'
  | 'email/super_campaign/lock'
  | 'email/super_campaign/mark_as_executed'
  | 'email/super_campaign/recipients'
  | 'email/super_campaign/table'
  | 'email/super_campaign/update'
  | 'email/super_campaign/update_eligibility'
  | 'email/super_campaign/update_tags'
  | 'email/thread/get'
  | 'email/thread/prune'
  | 'email/thread/update_google'
  | 'email/thread/update_microsoft'
  | 'email/threadMessage/check_by_thread'
  | 'email/threadMessage/get_by_thread'
  | 'envelope/account/get'
  | 'envelope/document/add-revision'
  | 'envelope/document/add'
  | 'envelope/document/get'
  | 'envelope/get'
  | 'envelope/get_deal'
  | 'envelope/insert'
  | 'envelope/recipient/add'
  | 'envelope/recipient/get'
  | 'envelope/recipient/update'
  | 'envelope/update'
  | 'envelope/user/delete'
  | 'envelope/user/expiring'
  | 'envelope/user/get'
  | 'envelope/user/insert'
  | 'envelope/void'
  | 'file/get-relations'
  | 'file/get'
  | 'file/get_role_files'
  | 'file/relation/delete'
  | 'file/relation/save'
  | 'file/remove'
  | 'file/rename'
  | 'file/save'
  | 'flow/create'
  | 'flow/current_steps'
  | 'flow/delete'
  | 'flow/get'
  | 'flow/migrate'
  | 'flow/remaining_steps'
  | 'flow/set_last_executed_at'
  | 'flow/step/create'
  | 'flow/step/delete'
  | 'flow/step/get'
  | 'flow/step/mark_executed'
  | 'flow/step/mark_failed'
  | 'flow/step/update'
  | 'form/by-brand'
  | 'form/context/insert'
  | 'form/data/insert'
  | 'form/get'
  | 'form/insert'
  | 'form/submission/get'
  | 'form/submission/get_revision'
  | 'form/submission/insert'
  | 'form/update'
  | 'gallery/get'
  | 'gallery/item/delete'
  | 'gallery/item/get'
  | 'gallery/item/insert'
  | 'gallery/item/sort'
  | 'gallery/item/update'
  | 'godaddy/domain/get'
  | 'godaddy/domain/save'
  | 'godaddy/domain/set-order'
  | 'godaddy/domain/set-zone'
  | 'godaddy/user/get_shopper'
  | 'godaddy/user/save_shopper'
  | 'google/calendar/delete_by_remote_cal_id'
  | 'google/calendar/get'
  | 'google/calendar/get_by_credential'
  | 'google/calendar/get_by_remote_cal'
  | 'google/calendar/get_same_owner_google_calendars'
  | 'google/calendar/insert'
  | 'google/calendar/remote_insert'
  | 'google/calendar/update_sync_token'
  | 'google/calendar/update_watcher'
  | 'google/calendar_events/count'
  | 'google/calendar_events/delete_by_cal_id'
  | 'google/calendar_events/delete_by_remote_ids'
  | 'google/calendar_events/delete_many'
  | 'google/calendar_events/get'
  | 'google/calendar_events/get_by_calendar'
  | 'google/calendar_events/get_by_calendar_and_event_ids'
  | 'google/calendar_events/get_by_calendar_ids'
  | 'google/calendar_events/get_moved_events'
  | 'google/calendar_events/insert'
  | 'google/calendar_events/update_calendar'
  | 'google/contact/count'
  | 'google/contact/delete'
  | 'google/contact/delete_contact_groups'
  | 'google/contact/get'
  | 'google/contact/get_by_entry_ids'
  | 'google/contact/get_by_google_credential'
  | 'google/contact/get_by_rechat_contacts'
  | 'google/contact/get_by_resource_ids'
  | 'google/contact/hard_delete'
  | 'google/contact/restore'
  | 'google/contact_group/get'
  | 'google/contact_group/get_by_credential'
  | 'google/credential/disconnect'
  | 'google/credential/get'
  | 'google/credential/get_by_brand'
  | 'google/credential/get_by_email'
  | 'google/credential/get_by_user'
  | 'google/credential/gmail_sync_due'
  | 'google/credential/insert'
  | 'google/credential/revoke'
  | 'google/credential/revoked'
  | 'google/credential/update_access_token'
  | 'google/credential/update_contact_groups_sync_token'
  | 'google/credential/update_contacts_sync_token'
  | 'google/credential/update_gmail_profile'
  | 'google/credential/update_last_daily_sync'
  | 'google/credential/update_messages_sync_history_id'
  | 'google/credential/update_other_contacts_sync_token'
  | 'google/credential/update_profile'
  | 'google/credential/update_rechat_gcalendar'
  | 'google/credential/update_refresh_token'
  | 'google/credential/update_tokens'
  | 'google/mail_labels/get'
  | 'google/mail_labels/get_by_credential'
  | 'google/mail_labels/upsert'
  | 'google/message/count'
  | 'google/message/delete_many'
  | 'google/message/filter_message_ids'
  | 'google/message/find_by_message_id'
  | 'google/message/find_distinc_credential'
  | 'google/message/find_distinc_credential_by_msg'
  | 'google/message/get'
  | 'google/message/get_by_credential'
  | 'google/message/get_by_credential_and_thread_keys'
  | 'google/message/get_by_internet_message_id'
  | 'google/message/get_by_message_id'
  | 'google/message/set_campaign'
  | 'google/message/update_is_read'
  | 'holiday/get'
  | 'holiday/upcoming'
  | 'listing/access'
  | 'listing/agents'
  | 'listing/area/get'
  | 'listing/area/get_by_area'
  | 'listing/area/refresh'
  | 'listing/area/search'
  | 'listing/county/refresh'
  | 'listing/county/search'
  | 'listing/delete'
  | 'listing/get'
  | 'listing/get_compacts'
  | 'listing/get_mls_number'
  | 'listing/get_mui'
  | 'listing/insert'
  | 'listing/interested'
  | 'listing/lock'
  | 'listing/matching'
  | 'listing/matching_users'
  | 'listing/string_search'
  | 'listing/subdivision/refresh'
  | 'listing/subdivision/search'
  | 'listing/touch'
  | 'listing/update_status'
  | 'message/get'
  | 'message/post'
  | 'message/retrieve'
  | 'message/unread'
  | 'microsoft/calendar/delete_by_remote_cal_id'
  | 'microsoft/calendar/get'
  | 'microsoft/calendar/get_by_credential'
  | 'microsoft/calendar/get_by_remote_cal'
  | 'microsoft/calendar/get_same_owner_microsoft_calendars'
  | 'microsoft/calendar/insert'
  | 'microsoft/calendar/update_delta_token'
  | 'microsoft/calendar/update_to_sync'
  | 'microsoft/calendar_events/count'
  | 'microsoft/calendar_events/delete'
  | 'microsoft/calendar_events/delete_by_cal_id'
  | 'microsoft/calendar_events/delete_by_remote_ids'
  | 'microsoft/calendar_events/delete_many'
  | 'microsoft/calendar_events/get'
  | 'microsoft/calendar_events/get_by_calendar_and_event_ids'
  | 'microsoft/calendar_events/get_by_calendar_ids'
  | 'microsoft/calendar_events/insert'
  | 'microsoft/calendar_events/restore_by_remote_ids'
  | 'microsoft/contact/count'
  | 'microsoft/contact/create'
  | 'microsoft/contact/delete'
  | 'microsoft/contact/get'
  | 'microsoft/contact/get_by_credential'
  | 'microsoft/contact/get_by_microsoft_credential'
  | 'microsoft/contact/get_by_rechat_contacts'
  | 'microsoft/contact/get_by_remote_folder_id'
  | 'microsoft/contact/get_by_remote_ids'
  | 'microsoft/contact/get_by_source'
  | 'microsoft/contact/hard_delete'
  | 'microsoft/contact/restore'
  | 'microsoft/contact/update'
  | 'microsoft/contact_folder/get'
  | 'microsoft/contact_folder/get_by_credential'
  | 'microsoft/contact_folder/insert'
  | 'microsoft/contact_folder/remove_by_credential'
  | 'microsoft/contact_folder/update_sync_token'
  | 'microsoft/credential/disconnect'
  | 'microsoft/credential/get'
  | 'microsoft/credential/get_by_brand'
  | 'microsoft/credential/get_by_user'
  | 'microsoft/credential/insert'
  | 'microsoft/credential/outlook_sync_due'
  | 'microsoft/credential/revoke'
  | 'microsoft/credential/revoked'
  | 'microsoft/credential/update_contact_folders_sync_token'
  | 'microsoft/credential/update_contacts_sync_token'
  | 'microsoft/credential/update_primary_email'
  | 'microsoft/credential/update_profile'
  | 'microsoft/credential/update_rechat_mcalendar'
  | 'microsoft/credential/update_send_email_after'
  | 'microsoft/credential/update_tokens'
  | 'microsoft/mail_folders/get'
  | 'microsoft/mail_folders/get_by_credential'
  | 'microsoft/mail_folders/upsert'
  | 'microsoft/message/count'
  | 'microsoft/message/delete_many'
  | 'microsoft/message/filter_message_ids'
  | 'microsoft/message/find_by_message_id'
  | 'microsoft/message/find_distinc_credential'
  | 'microsoft/message/find_distinc_credential_by_msg'
  | 'microsoft/message/get'
  | 'microsoft/message/get_as_thread_member'
  | 'microsoft/message/get_by_credential'
  | 'microsoft/message/get_by_credential_and_thread_keys'
  | 'microsoft/message/get_by_internet_message_id'
  | 'microsoft/message/get_by_remote_message_id'
  | 'microsoft/message/update_is_read'
  | 'microsoft/migration/get_contacts_without_new_id'
  | 'microsoft/migration/get_messages_without_new_id'
  | 'microsoft/migration/update_contacts_based_on_new_ids'
  | 'microsoft/migration/update_messages_based_on_new_ids'
  | 'microsoft/subscription/delete'
  | 'microsoft/subscription/get'
  | 'microsoft/subscription/get_by_credential'
  | 'microsoft/subscription/get_by_remote_id'
  | 'microsoft/subscription/get_by_resource'
  | 'microsoft/subscription/insert'
  | 'microsoft/subscription/update_expiration_time'
  | 'migration/load'
  | 'migration/save'
  | 'mls_job/insert'
  | 'mls_job/last_run'
  | 'notification/ack_personal'
  | 'notification/ack_room'
  | 'notification/ack_single'
  | 'notification/app_badge'
  | 'notification/delete'
  | 'notification/get'
  | 'notification/insert'
  | 'notification/insert_delivery'
  | 'notification/insert_user'
  | 'notification/patch_seen'
  | 'notification/register_push'
  | 'notification/tokens/delete'
  | 'notification/unread'
  | 'notification/unread_over_time'
  | 'notification/unread_room'
  | 'notification/unregister_push'
  | 'notification/user'
  | 'notification/user_channels'
  | 'office/get'
  | 'office/get_mls'
  | 'office/insert'
  | 'office/search'
  | 'open_house/get'
  | 'open_house/insert'
  | 'photo/bulk_insert'
  | 'photo/delete_missing'
  | 'photo/insert'
  | 'property/insert'
  | 'property_room/insert'
  | 'property_unit/insert'
  | 'recommendation/add_favorite'
  | 'recommendation/add_hid'
  | 'recommendation/add_read'
  | 'recommendation/add_reference_to_recs'
  | 'recommendation/favorites'
  | 'recommendation/feed'
  | 'recommendation/get'
  | 'recommendation/insert'
  | 'recommendation/map_to_alerts'
  | 'recommendation/mark_as_read'
  | 'recommendation/remove_favorite'
  | 'recommendation/remove_hid'
  | 'recommendation/remove_read'
  | 'recommendation/unhide_recs'
  | 'recommendation/user_favorites'
  | 'requests/get'
  | 'requests/insert'
  | 'review/get'
  | 'review/insert'
  | 'review/update'
  | 'room/add_user'
  | 'room/add_user_relaxed'
  | 'room/archive'
  | 'room/delete'
  | 'room/find_direct'
  | 'room/get'
  | 'room/get_recommendation'
  | 'room/hide_orphaned_recs'
  | 'room/insert'
  | 'room/leave'
  | 'room/lookup'
  | 'room/ok_push'
  | 'room/others'
  | 'room/seamless_resolve_phone'
  | 'room/seamless_resolve_room'
  | 'room/search_users'
  | 'room/string_search'
  | 'room/string_search_fuzzy'
  | 'room/toggle_push_settings'
  | 'room/update'
  | 'room/user/all-rooms'
  | 'room/user/get-users'
  | 'room/user/peers'
  | 'room/user_rooms'
  | 'school/district'
  | 'school/refresh'
  | 'school/search'
  | 'school/search_districts'
  | 'showing/appointment/approve'
  | 'showing/appointment/clear_notifications'
  | 'showing/appointment/feedback'
  | 'showing/appointment/get'
  | 'showing/appointment/get_public'
  | 'showing/appointment/insert'
  | 'showing/appointment/recently_done'
  | 'showing/appointment/reschedule'
  | 'showing/appointment/set_message'
  | 'showing/appointment/table'
  | 'showing/appointment/update_status'
  | 'showing/approvals/get'
  | 'showing/approvals/insert'
  | 'showing/approvals/table'
  | 'showing/availability/delete'
  | 'showing/availability/get'
  | 'showing/availability/insert'
  | 'showing/availability/table'
  | 'showing/availability/update'
  | 'showing/hub/appointment/find_by_appointment'
  | 'showing/hub/appointment/get'
  | 'showing/hub/appointment/insert'
  | 'showing/hub/appointment/table'
  | 'showing/hub/reoccuring/insert'
  | 'showing/hub/reoccuring/table'
  | 'showing/hub/restrictions/insert'
  | 'showing/hub/restrictions/table'
  | 'showing/hub/showable_listing/find_by_showing'
  | 'showing/hub/showable_listing/get'
  | 'showing/hub/showable_listing/insert'
  | 'showing/hub/showable_listing/table'
  | 'showing/notification/get'
  | 'showing/role/delete'
  | 'showing/role/find_by_user'
  | 'showing/role/get'
  | 'showing/role/insert'
  | 'showing/role/table'
  | 'showing/role/update'
  | 'showing/showing/access'
  | 'showing/showing/delete'
  | 'showing/showing/get'
  | 'showing/showing/get_buyer'
  | 'showing/showing/get_by_human_readable_id'
  | 'showing/showing/insert'
  | 'showing/showing/notifications'
  | 'showing/showing/table'
  | 'showing/showing/update'
  | 'showing/showing/update_title'
  | 'stripe/charge/get'
  | 'stripe/charge/save'
  | 'stripe/customer/delete'
  | 'stripe/customer/get'
  | 'stripe/customer/get_user'
  | 'stripe/customer/save'
  | 'task/by-room'
  | 'task/delete'
  | 'task/get'
  | 'task/insert'
  | 'task/reviews/add'
  | 'task/update'
  | 'template/asset/get'
  | 'template/asset/insert'
  | 'template/brand/allow-shared'
  | 'template/brand/allow'
  | 'template/brand/delete'
  | 'template/brand/for-brand'
  | 'template/brand/get-invalids'
  | 'template/brand/get'
  | 'template/brand/invalidate-brand'
  | 'template/brand/update-thumbnails'
  | 'template/brand/validate'
  | 'template/get'
  | 'template/insert'
  | 'template/instance/by-user'
  | 'template/instance/delete'
  | 'template/instance/get'
  | 'template/instance/insert'
  | 'template/instance/relation/insert'
  | 'template/instance/set-branch'
  | 'token/get'
  | 'token/insert'
  | 'trigger/active_contact_triggers'
  | 'trigger/brand_trigger/contact_ids_to_create_trigger_for'
  | 'trigger/brand_trigger/exclusions/create'
  | 'trigger/brand_trigger/exclusions/delete'
  | 'trigger/brand_trigger/exclusions/find_specific'
  | 'trigger/brand_trigger/exclusions/get_contacts'
  | 'trigger/brand_trigger/get'
  | 'trigger/brand_trigger/get_for_brand'
  | 'trigger/brand_trigger/toggle'
  | 'trigger/brand_trigger/upsert'
  | 'trigger/clear-origin'
  | 'trigger/create'
  | 'trigger/delete'
  | 'trigger/due'
  | 'trigger/get'
  | 'trigger/get_due'
  | 'trigger/get_pending_contact_triggers'
  | 'trigger/lock'
  | 'trigger/mark_executed'
  | 'trigger/mark_failed'
  | 'trigger/update'
  | 'user/add_agent'
  | 'user/bulk_search_email'
  | 'user/bulk_search_phone'
  | 'user/change_password'
  | 'user/check_pw_reset_token'
  | 'user/check_shadow_token_email'
  | 'user/check_shadow_token_phone'
  | 'user/confirm_email'
  | 'user/confirm_phone'
  | 'user/delete'
  | 'user/get'
  | 'user/get_by_agent'
  | 'user/get_by_email'
  | 'user/get_by_phone'
  | 'user/get_user_brands'
  | 'user/insert'
  | 'user/ok_push'
  | 'user/patch_avatars'
  | 'user/patch_timezone'
  | 'user/record_pw_recovery'
  | 'user/remove_pw_reset_token'
  | 'user/role/for-user'
  | 'user/seen'
  | 'user/sso/connect'
  | 'user/sso/get-user'
  | 'user/sso/provider/get-by-domain'
  | 'user/sso/provider/get-by-identifier'
  | 'user/sso/provider/get-by-user'
  | 'user/sso/provider/get'
  | 'user/update'
  | 'user/update_personal_room'
  | 'user/settings/get'
  | 'users_job/chk_lock'
  | 'users_job/delete'
  | 'users_job/get'
  | 'users_job/google/chk_lock_by_gcredential'
  | 'users_job/google/delete_by_gcredential'
  | 'users_job/google/delete_by_gcredential_and_job'
  | 'users_job/google/force_sync_by_gcredential'
  | 'users_job/google/gcal_sync_due'
  | 'users_job/google/gcontacts_avatarts_sync_due'
  | 'users_job/google/gcontacts_sync_due'
  | 'users_job/google/get_by_gcredential'
  | 'users_job/google/gmail_sync_by_query'
  | 'users_job/google/gmail_sync_due'
  | 'users_job/google/lock_by_gcredential'
  | 'users_job/google/postpone_sync_by_gcredential'
  | 'users_job/google/upsert_by_gcredential'
  | 'users_job/lock'
  | 'users_job/microsoft/chk_lock_by_mcredential'
  | 'users_job/microsoft/delete_by_mcredential'
  | 'users_job/microsoft/delete_by_mcredential_and_job'
  | 'users_job/microsoft/force_sync_by_mcredential'
  | 'users_job/microsoft/get_by_mcredential'
  | 'users_job/microsoft/lock_by_mcredential'
  | 'users_job/microsoft/mcal_sync_due'
  | 'users_job/microsoft/mcontacts_avatarts_sync_due'
  | 'users_job/microsoft/mcontacts_sync_due'
  | 'users_job/microsoft/microsoft_cal_sync_due'
  | 'users_job/microsoft/outlook_sync_by_query'
  | 'users_job/microsoft/outlook_sync_due'
  | 'users_job/microsoft/postpone_sync_by_mcredential'
  | 'users_job/microsoft/upsert_by_mcredential'
  | 'users_job/postpone'
  | 'users_job/restore'
  | 'users_job/update_status'
  | 'verification/email_insert'
  | 'verification/email_verify'
  | 'verification/phone_insert'
  | 'verification/phone_verify'
  | 'website/delete'
  | 'website/delete_hostname'
  | 'website/get'
  | 'website/get_hostname'
  | 'website/get_user'
  | 'website/insert'
  | 'website/insert_hostname'
  | 'website/update';
