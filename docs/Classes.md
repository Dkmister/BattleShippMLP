# Documentação referente a Classes
## Player
A classe Player é responsável por representar o jogador e suas ações tais como, bombardear outro player e posicionar seus navios. Além disso, cada jogador recebe pontos por acertar navios inimigos.

### Propriedades dos Players:

#### name
O atributo __name__ irá designar o nome do jogador.

#### points
O atributo __points__ irá designar a quantidade de pontos que um jogador receberá. Estará representado num intervalo de valores entre 0 a 200.

### Metódos dos Players:
#### `def SetShips()`
O metódo __SetShips()__ irá designar os espaços desejados e disponíveis para o jogador posicionar seus navios, dessa forma ocupando tais espaços.
#### `def hitEnemyPlayer()`
O metódo  __hitEnemyPlayer()__ fará a análise se um espaço foi atingido, caso seja, retornará __True__ , caso contrário, __False__ .

## GameState
A classe GameState será responsável por armazenar os espaços disponíveis do campo do jogo, e seus correspondentes estados. Além disso, ela também irá analisar e retornar se dada espaço está vazio ou não, e se o jogo já terminou.

### Propriedades de GameState:

#### Board
O atributo Board irá designar a tabela do jogo. Além disso, indicará qual é a board de cada Player.

#### State
O atributo State será uma lista para guardar as jogadas de maneira imutável, para futuramente poder ser utilizado no paradigma funcional.

### Metódos de GameState
#### `def isEmpty?()`
O metódo __isEmpty?()__ verifica se o espaço é vazio, caso sim, retorna __true__, caso contrário, retorna __false__
#### `def SpaceHitPoints()`
O metódo __SpaceHitPoints()__ retorna a pontuação, caso isEmpty? retorne falso.
#### `def GameOver?()`
O metódo __GameOver?()__verifica se o jogo acabou. Caso sim, retorna __true__, caso contrário, retorna __false__




