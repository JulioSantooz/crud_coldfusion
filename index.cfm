<cfset setLocale("Portuguese (Brazilian)")>

<cfif isDefined("form.operacao")>
    <!-- Se a operação for igual a 'editar', significa que vamos fazer um UPDATE no banco de dados -->
    <cfif #form.operacao# eq "editar">
        <cfquery datasource="loja_de_instrumentos_dsn" name="queryPedidos">
            UPDATE pedidos
            SET  item = "#form.item#"
                ,modelo = "#form.modelo#"
                ,nome = "#form.nome#"
                ,email = "#form.email#"
                ,preco = "#form.preco#"
            WHERE id = "#form.id#"
        </cfquery>

        <cfset form.operacao = "">
    </cfif>
    <!-- Se a operação for igual a 'adicionar', significa que vamos fazer um CREATE no banco de dados -->
    <cfif #form.operacao# eq "adicionar">
        <cfquery datasource="loja_de_instrumentos_dsn" name="queryPedidos">
            INSERT into pedidos (item, modelo, nome, email, preco) 
            values ("#form.item#","#form.modelo#","#form.nome#","#form.email#","#form.preco#")           
        </cfquery>

        <cfset form.operacao = "">
    </cfif>    
</cfif>

<!-- Query para buscar todos os dados da tabela pedidos-->
<cfquery datasource="loja_de_instrumentos_dsn" name="queryPedidos">
    SELECT id, item, modelo, nome, email, preco FROM pedidos
</cfquery>

<!DOCTYPE html>
<html>

    <head>
        <title>
            Loja de Instrumentos
        </title>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" 
              href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
              integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" 
              crossorigin="anonymous">

        <link rel="stylesheet" href="outros-arquivos/style.css">
    </head>
    
    <body>
        <header>
            <nav class="navbar navbar-expand-md navbar-dark" style="background-color: #541734">
                <div>
                    <a href="#" class="navbar-brand">Loja de Instrumentos</a>
                </div>
                
                <ul class="navbar-nav">
                    <li>
                        <a href="/crud_produto" class="nav-link">
                            Gest&atilde;o de Pedidos
                        </a>
                    </li>
                </ul>
            </nav>
        </header>

        <div class="row">
            <div class="container">
                <h3 class="text-center mt-5 mb-5">
                    Listagem de Pedidos
                </h3>
                <p>
                    <a href="pedidos-form.cfm" class="btn btn-primary">
                        Novo Pedido 
                    </a>
                </p>
			    <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Item</th>
                            <th>Modelo</th>
                            <th>Cliente</th>
                            <th>Email</th>
                            <th>Pre&ccedil;o</th>
                            <th> </th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Apresenta os dados do Data Base para a tabela Web -->
                        <cfoutput query="queryPedidos">
                            <tr>
                                <td scope="row">#queryPedidos.item#</td>
                                <td>#queryPedidos.modelo#</td>
                                <td>#queryPedidos.nome#</td>
                                <td>#queryPedidos.email#</td>
                                <td>#lsCurrencyFormat(queryPedidos.preco)#</td>
                                <td> 
                                    <a href="pedidos-form.cfm?id=#queryPedidos.id#" class="btn btn-primary">
                                        Editar
                                    </a>                                      

                                    <button type='button' class='btn btn-danger' data-toggle='modal' data-target='##exampleModal' onclick='$(".delete_id").val(#queryPedidos.id#)'>
                                        Apagar
                                    </button>
                                </td>
                            </tr>                            
                        </cfoutput>
                    </tbody>
                </table>

                <!-- Modal -->
                <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <input type="hidden" name="delete_id" class="delete_id">

                                <h5 class="modal-title" id="exampleModalLabel">Deseja realmente apagar o registro?</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Não</button>
                                <button type="submit" class="btn btn-danger" onclick="deleteRecord()" data-dismiss="modal">Sim</button>                                
                            </div>
                        </div>
                    </div>
                </div>                
            </div>
        </div>

        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

        <script>
            function deleteRecord() {
                var id = $(".delete_id").val();
                $.ajax({
                    url:"http://localhost:8500/crud_pedidos/pedidos-delete.cfm",
                    method:"POST",
                    data:{
                        id: id,
                    },
                    success:function(response) {
                        location.reload();
                    },
                });
            } 
        </script>
        
        <script>
            if (window.history.replaceState) {
                window.history.replaceState(null, null, window.location.href);
            }
        </script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" 
                integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" 
                crossorigin="anonymous">
        </script>

        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" 
                integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" 
                crossorigin="anonymous">
        </script>
    </body>
</html>