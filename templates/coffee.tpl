require.register "<%= filePath %>", (exports, require, module) ->
  $0
  <% if (moduleExports) { %>
  module.exports = <%= moduleExports %>
  <% } %>

<% if (autoRequire) { %>
require "<%= filePath %>"
<% } %>
