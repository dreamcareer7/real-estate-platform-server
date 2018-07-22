const globals = [
  'Error',
  'Orm',
  'Job',
  'Template',
  'Address',
  'User',
  'CompactUser',
  'Session',
  'Client',
  'Token',
  'Property',
  'Listing',
  'CompactListing',
  'Room',
  'Recommendation',
  'Url',
  'Contact',
  'Alert',
  'Email',
  'MLSArea',
  'SMS',
  'Crypto',
  'ObjectUtil',
  'Verification',
  'EmailVerification',
  'PhoneVerification',
  'Branch',
  'Tag',
  'Photo',
  'MLSJob',
  'Agent',
  'Metric',
  'Socket',
  'OpenHouse',
  'Office',
  'PropertyUnit',
  'PropertyRoom',
  'CMA',
  'Brand',
  'School',
  'Intercom',
  'Google',
  'Notification',
  'Message',
  'Slack',
  'SocketServer',
  'Twilio',
  'Website',
  'Stripe',
  'Godaddy',
  'Form',
  'Deal',
  'DealContext',
  'DealRole',
  'Envelope',
  'EnvelopeRecipient',
  'Activity',
  'AttachedFile',
  'Submission',
  'Task',
  'Review',
  'DealChecklist',
  'BrandChecklist',
  'BrandRole',
  'BrokerWolf',
  'UserRole'
]

const global_object = {}
globals.forEach(var_name => {
  global_object[var_name] = true
})

module.exports = function (app) {
  for (var i in files)
    require(files[i])
}
module.exports = {
  'globals': global_object,
  'env': {
    'es6': true,
    'node': true
  },
  'parserOptions': {
    'ecmaVersion': 10,
    'ecmaFeatures': {
    }
  },
  'extends': 'eslint:recommended',
  'rules': {
    'indent': [
      'error',
      2,
      {"SwitchCase": 1}
    ],
    'linebreak-style': [
      'error',
      'unix'
    ],
    'quotes': [
      'error',
      'single'
    ],
    'no-var': 'error',
    'semi': [
      'error',
      'never'
    ],
    'no-extra-semi': 'error',
    'prefer-const': 'error',
    'no-unused-vars': [
      'error',
      {'vars': 'all', 'args': 'none'}
    ],
    'no-console': 'off',
    'no-empty': [
      'error',
      {'allowEmptyCatch':true}
    ],
    'key-spacing': [
      'error'
    ],
    'space-infix-ops': [
      'error'
    ],
    'no-cond-assign': [
      'error'
    ],
    'no-dupe-args': [
      'error'
    ],
    'no-dupe-keys': [
      'error'
    ],
    'no-duplicate-case': [
      'error'
    ],
    'no-empty-character-class': [
      'error'
    ],
    'no-empty': [
      'error'
    ],
    'no-extra-boolean-cast': [
      'error'
    ],
    'no-extra-semi': [
      'error'
    ],
    'no-obj-calls': [
      'error'
    ],
    'no-unexpected-multiline': [
      'error'
    ],
    'no-unreachable': [
      'error'
    ],
    'no-unsafe-negation': [
      'error'
    ],
    'use-isnan': [
      'error'
    ],
    'valid-typeof': [
      'error'
    ],
    'default-case': [
      'error'
    ],
    'eqeqeq': [
      'error'
    ],
    'no-alert': [
      'error'
    ],
    'no-caller': [
      'error'
    ],
    'no-case-declarations': [
      'off'
    ],
    'no-else-return': [
      'error'
    ],
    'no-eq-null': [
      'error'
    ],
    'no-eval': [
      'error'
    ],
    'no-extra-bind': [
      'error'
    ],
    'no-extra-label': [
      'error'
    ],
    'no-fallthrough': [
      'error'
    ],
    'no-floating-decimal': [
      'error'
    ],
    'no-global-assign': [
      'error'
    ],
    'no-implicit-coercion': [
      'error'
    ],
    'no-implicit-globals': [
      'error'
    ],
    'yoda': [
      'error'
    ],
    'no-with': [
      'error'
    ],
    'no-void': [
      'error'
    ],
    'no-useless-call': [
      'error'
    ],
    'no-unused-labels': [
      'error'
    ],
//     'no-unused-expressions': [
//       'error'
//     ],
    'no-unmodified-loop-condition': [
      'error'
    ],
    'no-sequences': [
      'error'
    ],
    'no-self-compare': [
      'error'
    ],
    'no-self-assign': [
      'error'
    ],
    'no-return-assign': [
      'error'
    ],
    'no-redeclare': [
      'error'
    ],
    'no-proto': [
      'error'
    ],
    'no-new': [
      'error'
    ],
    'no-new-wrappers': [
      'error'
    ],
    'no-new-func': [
      'error'
    ],
    'no-multi-spaces': [
      'error'
    ],
    'no-invalid-this': [
      'error'
    ],
    'no-implied-eval': [
      'error'
    ],
    'callback-return': [
      'error'
    ],
    'handle-callback-err': [
      'error'
    ]
  }
}
