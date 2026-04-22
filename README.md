# UnitFrame
Um Godot com arquitetura CBS parcial.

UnitFrame é um plugin (não publicado) para *jogos 2D*  no Godot que permite adicionar *arquitetura CBS* ao Godot (parcialmente).

## O que é CBS ❓
CBS é uma arquitetura de sistema baseado em componentes (Component-Based System). Nesse padrão de design de games, a prioridade é a reusabilidade de códigos e sistemas. Nessa arquitetura, tudo na hierarquia é uma entidade, mas diferente da arquitetura OOP, a herança de classes é pouco usada. Na verdade, uma entidade é construída a partir da junção de componentes. Um cavalo não é um objeto da classe cavalo que herdou da classe animal, e sim uma entidade com os componentes: Movimentação_Generica, Montavel, Vida.

## Por que usar o UnitFrame ❓
### 🤖 Automação
Diferente de outros plugins de CBS, o UnitFrame não foca em te dar uma variedade de componentes avançados prontos para você usar, e sim na parte de componentes simples e repetitivos que quase todo jogo tem e na parte de criar seus próprios componentes, facilitando o processo de criar a base do seu jogo sem acidentalmente "espaguetificar" o código.

### 🥱 Facilidade
É chato criar ou colar uma movimentação básica, sistema de pulo e gravidade toda vez que você cria um jogo, já que geralmente isso é algo que tem em todo jogo, então por que não automatizar isso simplesmente colocando um componente de "KeyboardController", "Gravity" e "Jump" no seu personagem?

### 🔧 Personalização
Além do mais, com a habilidade de criar seus próprios componentes independentes, adicionar novas funcionalidades sem sair dessa arquitetura ou fazer gambiarra é muito fácil. E se quiser criar uma nova classe de entidade com novas funcionalidades? Também é possível! A classe Entity2D foi feita exatamente para que outras classes pudessem ser criadas herdando-a e até sobrescrevessem as funções _ready, _process e _physics_process sem problema, já que o crucial está na função _notification.

## Por que "parcial" ❓
UnitFrame é um plugin e não força essa arquitetura. Você pode misturar a arquitetura CBS e OOP no seu projeto. Na verdade, a própria implementação desse padrão de design depende do OOP para fazer a separação de "Componente" e "Entidade". De qualquer maneira, embora o UnitFrame te dê a base para essa estrutura, onde ela será usada ou não cabe a você decidir.

## Como baixar ❓
🔽 Baixe o repositório no GitHub: https://github.com/NinjaMestre/UnitFrame/tree/main

## Como usar ❓
Extraia o arquivo zip para uma pasta no seu projeto 2D, de preferência uma chamada "unitframe".
Nessa pasta, adicione o script "entity_2d.gd" a qualquer nó. Agora, esse nó tem uma lista de componentes.

### Como criar meu próprio componente ❓
Crie um novo script na pasta "components" do UnitFrame.
Nesse script, herde a classe Component.
Embora as funções _ready, _process e _physics_process sejam da classe Node, elas foram adicionadas à classe Component. Quem programa no Godot sabe que 99% dos scripts herdam uma classe que direta ou indiretamente herda de Node, porque a arquitetura do Godot é essa, de tudo ser um node. Então, para facilitar a adaptação e diminuir a diferença entre escrever para um script de Node e de Component, as 3 principais funções dos Nodes foram copiadas para os Components.

#### ⚡ Funções e Eventos
_ready => executa quando o componente é criado;
_process => executa a cada quadro;
_physics_process => executa a cada quadro com uma taxa de quadros fixa;

predelete => evento que é acionado logo antes do componente ser deletado.

### Como criar minha própria entidade ❓
Se você quiser criar uma classe que herda da Entity2D para adicionar novos recursos, você pode fazer isso desde que não sobrescreva a função _notification, já que a funcionalidade da Entity2D está lá e sem o código que está lá, os componentes não serão executados. A menos, claro, que você copie o código da _notification da Entity2D e cole aí. Aí tá tudo bem.
