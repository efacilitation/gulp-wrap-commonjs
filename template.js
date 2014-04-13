require.register("<%= filePath %>", function(exports, require, module){
  <%= contents %>
  <% if (moduleExports != "undefined") { %>
  module.exports = <%= moduleExports %>;
  <% } %>
});
<% if (autoRequire === true) { %>
require("<%= filePath %>");
<% } %>