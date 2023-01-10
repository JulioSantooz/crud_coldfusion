<!-- Se tivermos o id do pedido, logo podemos exclui-lo-->
<cfif isDefined("form.id")>
    <cfquery datasource="loja_de_instrumentos_dsn" name="queryPedidos">
        DELETE FROM pedidos WHERE id=#form.id#
    </cfquery>
</cfif>

<cflocation url="index.cfm" >