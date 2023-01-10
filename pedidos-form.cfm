<!-- Se atualizarmos o campo de preço, teremos a conversão para o formato do Brasil R$ -->
<cfset setLocale("Portuguese (Brazilian)")>
<!-- <cfparam name="URL.id" default="0" > -->

<!-- Se o id é passado por parametro, significa que o pedido existe e que o cliente quer editar o pedido existente -->
<cfif isDefined("URL.id")>
    <cftry>
        <cfquery datasource="loja_de_instrumentos_dsn" name="queryPedidos">
            SELECT id, item, modelo, nome, email, preco 
            FROM pedidos
            WHERE id = <cfqueryparam value="#URL.id#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cfcatch>
            <cflocation url="index.cfm" >
        </cfcatch>   
    </cftry>
<!-- Se o id não é passado por parametro, significa que o pedido não existe e que o cliente quer criar um novo pedido -->
<cfelse>
    <cfset queryPedidos = StructNew()>
    <cfset queryPedidos.id = 0>
    <cfset queryPedidos.item = "">
    <cfset queryPedidos.modelo = "">
    <cfset queryPedidos.nome = "">
    <cfset queryPedidos.email = "">
    <cfset queryPedidos.preco = 0>
</cfif>

<html lang="pt">
    <head>
        <title>Loja de Instrumentos</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <meta charset="utf-8">    
    </head>
    <body>
        <header>
            <nav class="navbar navbar-expand-md navbar-dark" style="background-color: #541734">
                <div>
                    <a href="/crud_produto" class="navbar-brand">
                        Loja de Instrumentos 
                    </a>
                </div>

                <ul class="navbar-nav">
                    <li>
                        <a href="/crud_pedidos" class="nav-link">
                            Gest&atilde;o de Pedidos
                        </a>
                    </li>
                </ul>
            </nav>
        </header>
        <br/>
        <div class="container col-md-5">
            <div class="card mt-5">
                <div class="card-body">
                    <!-- Se dentro da URL temos o id, significa que o titulo do formulário vai ser 'Editando Pedido' e o campo 'operacao' vai guardar o valor 'editar' -->
                    <cfif '#queryPedidos.item != ""#'>
                        <form action="index.cfm" method="post">
                        <input type="hidden" name="operacao" value="editar"/>                    
                        <h2>Editando Pedido</h2>
                    <!-- Se dentro da URL não temos o id, significa que o titulo do formulário vai ser 'Adicionando Pedido' e o campo 'operacao' vai guardar o valor 'adicionar' -->
                    <cfelse>
                        <form action="index.cfm" method="post">
                        <input type="hidden" name="operacao" value="adicionar"/>                    
                        <h2>Adicionando Pedido</h2>
                    </cfif>

                    <!-- Retornando os dados do pedido selecionado para a operação de 'Edição' -->
                    <cfoutput>
                        <cfif isDefined("URL.id")>
                            <input type="hidden" name="id" value="#queryPedidos.id#"/>
                        </cfif>

                        <fieldset class="form-group">
                            <label>Item</label> <input type="text"
                                value="#queryPedidos.item#" class="form-control"
                                name="item" required="required">
                        </fieldset>

                        <fieldset class="form-group">
                            <label>Modelo</label> <input type="text"
                                value="#queryPedidos.modelo#" class="form-control"
                                name="modelo">
                        </fieldset>

                        <fieldset class="form-group">
                            <label>Nome</label> <input type="text"
                                value="#queryPedidos.nome#" class="form-control"
                                name="nome">
                        </fieldset>

                        <fieldset class="form-group">
                            <label>Email</label> <input type="text"
                                value="#queryPedidos.email#" class="form-control"
                                name="email">
                        </fieldset>

                        <fieldset class="form-group">
                            <label>Preço</label> R$ <input type="number" step="0.01" min="0.01"
                                value="#queryPedidos.preco#" class="form-control"
                                name="preco">
                        </fieldset>
                    </cfoutput>

                    <button type="submit" class="btn btn-success">Salvar</button>
                    <a href="/crud_pedidos" class="btn btn-success">Voltar</a>

                    </form>
                </div>
            </div>
        </div>
    </body>
</html>