Feature: characters
Acessar uma lista de personagens do RickMorty. 

cenário: Acessa o app e uma lista é carregada
dado: Inicializa o app,
quando: Carrega tela inicial,
Então: O sistema deve mostra uma lista com os 10 primeiros personagens,

cenário: Rolar lista até o final dos itens já carregados.
Dado: Lista é rolada até o final,
quando: dados foram carregados,
então: Novos itens devem ser solicitados na API, e adicionados a lista.

Cenário: Lista não exibida.
Dado: lista não foi carregada,
quando: inicializado o app.
então: Mensagem de erro deve ser exibida.

Cenário: Acessar item da lista
Dado: cliente clica em item da lista,
quando: lista é exibida,
então: acessa detalhes do item.

Cenário: Cliente pesquisa por um item.
Dado: cliente informa no campo 'buscar' o item que deseja pesquisar.
quando: lista é exibida,
então: o item com os dados fornecidos é mostrado.