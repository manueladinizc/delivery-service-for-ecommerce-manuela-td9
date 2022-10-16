## Delivery Service for E-commerce

A plataforma tem o objetivo de gerenciar uma frota de entrega para um e-commerce, a partir do cadastro de novos pedidos de frete (ordens de serviço) e fazer os cálculos de frete de acordo com os tipos de transporte que atendem ao perfil do pedido. É possível controlar as ordens de serviço em andamento, encerrar ordens de serviço e consultar o status da frota de veículos da empresa.

A evolução e backlog do projeto pode ser acompanhado pelas ferramentas abaixo:
-GitHub Project: https://github.com/users/manueladinizc/projects/1/views/2

-Trello: https://trello.com/invite/b/I98f4y2Q/b646e85996126c27533b9aca0c799240/treinadev-sistema-de-frete 

# Models criados

* 'Modality': Armazena as informações de cada modalidade de transporte como seu nome e sua taxa fixa.
* 'Vehicle': Armazena as informações de cada veículo cadastrado.
* 'Weight_price', 'Distance_price', 'Deadline': Armazenam informações para representar uma tabela de valores e taxas respectivamente para uma tabela de preços por peso, preços por distância e prazos de entrega.
* 'Work_order': Armazena os dados da ordem de serviço que será aberta. Ela possui as informações de peso e distância que serão usados nos cálculos do preço total.
* 'Open_work_order': Armazena a data do prazo previsto de entrega e o preço total do serviço.
* 'Close_work_order': Armazena a data que a entrega foi realizada e a descrição do motivo, caso a entrega ocorra com atraso.
* 'User_adm' e 'User_regular': São os grupos de usuários que poderão ter acesso a plataforma, ambos só podem realizar cadastro com domain '@sistemadefrete.com.br', mas para cada perfil existem algumas restrições nas funcionalidades.

## Funcionalidades
 
* Disponíveis:  
    - Cadastrar, editar e visualizar modalidades
    - Usuários administradores e regulares têm papéis diferentes
    - Cadastrar e editar dados veículos, enviar um veículo para manutenção e buscar um veículo a partir de sua placa para consultar sua situação atual
    - Tabelas de peso, distância e prazo com intervalos e taxas para as modalidades já cadastradas
    - Usuários podem consultar todos os preços cadastrados
    - Usuário administrador pode cadastrar uma nova ordem de serviço
    - Usuários regulares podem iniciar uma ordem de serviço através da lista de serviços pendentes
    - É exibido uma tabela com as modalidades aptas a atender a ordem de serviço e os respectivos prazo e valor de cada modalidade
    - Ordem de serviço só é aberta a partir da escolha da modalidade, para que a taxa seja aplicada
    - Usuários regulares podem ver todas as ordens de serviço em andamento e encerrá-las
    - Ao encerrar uma ordem de serviço é registrada a data de conclusão/entrega.
    - Um status é automaticamente atribuído à ordem de serviço indicando se a entrega foi feita dentro do prazo ou com atraso
    - Caso a ordem de serviço seja finalizada com atraso, o usuário deve informar o motivo do atraso para consulta futura
    - Um visitante, não autenticado, pode consultar a entregas através da tela inicial
    - Para consultar dados da entrega deve ser informado o código único da ordem de serviço completo
    - Exibir motivo do atraso em caso de encerramento com atraso
* Em desenvolvimento:
    - Cadastro de preços praticados para cada modalidade de transporte
    - Sistema deve alocar automaticamente um veículo disponível para realizar a entrega e disponibilizar o mesmo quando a entrega for concluída.

 

## Acesso as funcionalidades da plataforma

* Baixe e acesso o repositório através dos comandos comandos:
`git clone https://github.com/manueladinizc/delivery-service-for-ecommerce-manuela-td9.git`
`cd delivery-service-for-ecommerce-manuela-td9`

* A versão utilizada para esse projeto foi `ruby 3.1.0`. Em caso de diferença de versões, instale a versão referente ao projeto. 

* Execute as 'migration':
`rails db:migration`

* Popular o db:
`rails db:seed`

* Inicie o servidor:
`rails s`

* Para acessar como usuário administrador:
    login: manuela@sistemadefrete.com.br
    senha: password

* Para acessar como usuário regular:
        login: manu@sistemadefrete.com.br
        senha: password

# Observação

* O preço final foi calculado da seguinte maneira:
     Através do peso e distância fornecida na ordem de serviço
    `Preço total = (taxa pelo peso * distância) + taxa da distância + taxa fixa`