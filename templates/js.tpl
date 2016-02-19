require.register("<%= filePath %>", function(exports, require, module){
  $0
  <% if (moduleExports) { %>
  module.exports = <%= moduleExports %>;
  <% } %>
});
<% if (autoRequire) { %>
require("<%= filePath %>");
<% } %>
