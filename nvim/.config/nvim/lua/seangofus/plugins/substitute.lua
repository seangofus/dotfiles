return {
  'gbprod/substitute.nvim',
  opts = {},
  keys = {
    { 's', function() require('substitute').operator() end, desc = 'Substitute with register' },
    { 'ss', function() require('substitute').line() end, desc = 'Substitute line with register' },
    { 'S', function() require('substitute').eol() end, desc = 'Substitute to end of line with register' },
    { 's', function() require('substitute').visual() end, mode = 'x', desc = 'Substitute visual with register' },
  },
}
