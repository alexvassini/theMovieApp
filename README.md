# Objetivo 

Criar um MVP de um app de catalogo de filmes que lista os filmes mais populares segundo o site https://www.themoviedb.org.

# Referencias:

-> API: https://developers.themoviedb.org/3/getting-started/introduction
-> Paralax Header: https://blog.usejournal.com/parallax-header-with-just-constraints-c3df8a9244fc
-> RXMarbles: https://rxmarbles.com

# Arquitetura:

O Projeto foi construido em MVVM usando RxSwift em todas as camadas.
Cada View é um modulo que possui seu próprio .xib, view e viewModel
A Navegação é feita pela classe AppCoordinator

# Bibliotecas: 

* [RXSwift]: Framework de programação reativa 
* [Rx-Moya]: Camada de abstração para chamadas de Api para tornar o desenvolvimento mais simples e sobrar mais tempo para tomar café
* [R.swift]: Type safe ressources, fontes, assets, tableviewCells e essas coisas que sempre dao dor de cabeça
* [Lottie]: Para tornar o App mais animado (badum tss 🥁)

[RXSwift]: <https://github.com/ReactiveX/RxSwift>
[Rx-Moya]: <https://github.com/Moya/Moya>
[R.Swift]: <https://github.com/mac-cain13/R.swift>
[Lottie]: <https://github.com/airbnb/lottie-ios>

# Melhorias futuras

* Fazer requisição de outras listas que a api fornece
* Mostrar lista de atores do filme
* Criar tela de perfil dos atores
* Melhorar apresentação do componente de reviews
