require.register("<%= filePath %>", function(exports, require, module){
  <%= contents %>
  <% if (moduleExports) { %>
  module.exports = <%= moduleExports %>;
  <% } %>
});
<% if (autoRequiretrue) { %>
require("<%= filePath %>");
<% } %>