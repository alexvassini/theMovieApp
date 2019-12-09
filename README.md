# Objetivo 

Criar um MVP de um app de catalogo de filmes que lista os filmes mais populares segundo o site https://www.themoviedb.org.

# Referencias:

* API: https://developers.themoviedb.org/3/getting-started/introduction
* Paralax Header: https://blog.usejournal.com/parallax-header-with-just-constraints-c3df8a9244fc
* RXMarbles: https://rxmarbles.com
* iOS Architecture: MVVM-C: https://medium.com/sudo-by-icalia-labs/ios-architecture-mvvm-c-introduction-1-6-815204248518

# Arquitetura:

* O Projeto foi construido em MVVM+C usando RxSwift em todas as camadas.
👉 https://medium.com/sudo-by-icalia-labs/ios-architecture-mvvm-c-introduction-1-6-815204248518

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

* Implementar paginação na busca
* Melhorar cobertura de testes
* Fazer requisição de outras listas que a api fornece
* Mostrar lista de atores do filme
* Criar tela de perfil dos atores
