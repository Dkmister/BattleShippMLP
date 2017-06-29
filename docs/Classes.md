# Documentação referente a Classes
## Player
A classe __Player__ é responsável por representar o jogador e suas ações tais como, bombardear outro player e posicionar seus navios. Além disso, cada jogador recebe pontos por acertar navios inimigos.

### Propriedades dos Players:

#### name
O atributo __name__ irá designar o nome do jogador.

#### points
O atributo __points__ irá designar a quantidade de pontos que um jogador receberá. Estará representado num intervalo de valores entre 0 a 200.

### Metódos dos Players:
#### `def SetShips()`
O metódo __SetShips()__ irá designar os espaços desejados e disponíveis para o jogador posicionar seus navios, dessa forma ocupando tais espaços.
#### `def ShootEnemyPlayer()`
O metódo  __ShootEnemyPlayer()__ fará a análise se um espaço foi atingido, caso seja, retornará __True__ , caso contrário, __False__ .
#### `def SetName()`
O metódo __SetName()__ irá definir o nome do Player

## GameState
A classe __GameState__ será responsável por armazenar os espaços disponíveis do campo do jogo, e seus correspondentes estados. Além disso, ela também irá analisar e retornar se dada espaço está vazio ou não, e se o jogo já terminou.

### Propriedades de GameState:

#### Board
O atributo __Board__ irá designar a tabela do jogo. Além disso, indicará qual é a board de cada Player.

#### State
O atributo __State__ será uma lista para guardar as jogadas de maneira imutável, para futuramente poder ser utilizado no paradigma funcional.

### Metódos de GameState
#### `def isEmpty?()`
O metódo __isEmpty?()__ verifica se o espaço é vazio, caso sim, retorna __true__, caso contrário, retorna __false__
#### `def SpaceHitPoints()`
O metódo __SpaceHitPoints()__ retorna a pontuação, caso __isEmpty?()__ retorne falso.
#### `def GameOver?()`
O metódo __GameOver?()__ verifica se o jogo acabou. Caso sim, retorna __true__, caso contrário, retorna __false__

## Menu
A classe __Menu__ será responsável por controlar o menu inicial de seleção para o usuário.

### Propriedades de Menu:

#### LoopMenu
O atributo __LoopMenu__ irá indicar se o Menu estará em seu loop, haverá dois casos, um que ele irá para o jogo propriamente dito, e para a finalização.

### Metódos de Menu
#### `def SelectOption()`
O metódo __SelectOption()__ selecionará uma opção de todas do Menu.
#### `def Exit()`
O metódo __Exit()__ fará o término da aplicação, fazendo a saída do Menu.

## Ship
A classe __Ship__ irá designar as características dos navios e suas atuais situações.

### Propriedades de Ship

#### name
O atributo __name__ irá designar o nome da navio.

#### damage
O atributo __damage__ irá designar o dano do navio, se ele está intacto, danificado ou destruído.

#### position
O atributo __positions__ irá designar as posições e consequentemente, seu tamanho. 

#### Metódos de Ship
#### `def SetName()`
O metódo __SetName()__ será extramemente parecido com o da classe __Player__ , ele irá definir o nome do navio.



