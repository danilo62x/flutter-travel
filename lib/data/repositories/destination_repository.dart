import '../../domain/models/destination.dart';
import '../../domain/models/review.dart';
import '../services/destination_api_service.dart';

/// Repository exposing a SYNCHRONOUS seed (for instant, populated UI) plus a
/// real async fetch backed by the API service.
class DestinationRepository {
  DestinationRepository({DestinationApiService? service})
      : _service = service ?? DestinationApiService();

  final DestinationApiService _service;

  /// Instant, offline data used to render content immediately.
  List<Destination> seed() {
    return const <Destination>[
      Destination(
        id: 'rio',
        name: 'Rio de Janeiro',
        country: 'Brasil',
        rating: 4.8,
        priceLabel: 'R\$ 1.200',
        kind: DestinationKind.place,
        reviewCount: 2841,
        description:
            'Entre o mar e a montanha, o Rio combina praias icônicas, trilhas '
            'na Mata Atlântica e uma vida cultural intensa. Suba ao Pão de '
            'Açúcar ao entardecer, caminhe por Ipanema e termine a noite ao '
            'som de uma roda de samba na Lapa.',
        tags: <String>['Praia', 'Natureza', 'Vida noturna'],
      ),
      Destination(
        id: 'lisboa',
        name: 'Lisboa',
        country: 'Portugal',
        rating: 4.7,
        priceLabel: 'R\$ 3.450',
        kind: DestinationKind.place,
        reviewCount: 1976,
        description:
            'Colinas, azulejos e bondes amarelos: Lisboa é feita para se perder '
            'a pé. Descubra miradouros com vista para o Tejo, prove pastéis de '
            'nata quentinhos e ouça o fado ecoar pelas vielas de Alfama.',
        tags: <String>['Cultura', 'Gastronomia', 'História'],
      ),
      Destination(
        id: 'santiago',
        name: 'Santiago',
        country: 'Chile',
        rating: 4.6,
        priceLabel: 'R\$ 2.100',
        kind: DestinationKind.place,
        reviewCount: 1420,
        description:
            'Aos pés da Cordilheira dos Andes, Santiago mistura bairros '
            'boêmios, vinícolas de classe mundial e neve a poucas horas do '
            'centro. Ideal para quem quer cidade e montanha na mesma viagem.',
        tags: <String>['Montanha', 'Vinhos', 'Urbano'],
      ),
      Destination(
        id: 'chapada',
        name: 'Trilha na Chapada',
        country: 'Chapada Diamantina, BA',
        rating: 4.9,
        priceLabel: 'R\$ 320',
        kind: DestinationKind.experience,
        reviewCount: 638,
        description:
            'Cachoeiras cristalinas, grutas e vales infinitos: uma expedição '
            'guiada de três dias pelo coração da Chapada Diamantina, com banho '
            'no Poço Azul e pôr do sol no Morro do Pai Inácio.',
        tags: <String>['Trilha', 'Aventura', 'Cachoeira'],
      ),
      Destination(
        id: 'vinho',
        name: 'Rota do Vinho',
        country: 'Vale dos Vinhedos, RS',
        rating: 4.7,
        priceLabel: 'R\$ 480',
        kind: DestinationKind.experience,
        reviewCount: 512,
        description:
            'Um passeio por vinícolas centenárias no Vale dos Vinhedos, com '
            'degustação de rótulos premiados, harmonização com queijos da serra '
            'e paisagens de parreirais que se estendem até o horizonte.',
        tags: <String>['Vinhos', 'Gastronomia', 'Campo'],
      ),
      Destination(
        id: 'mergulho',
        name: 'Mergulho em Noronha',
        country: 'Fernando de Noronha, PE',
        rating: 5.0,
        priceLabel: 'R\$ 650',
        kind: DestinationKind.experience,
        reviewCount: 894,
        description:
            'Águas transparentes, tartarugas e golfinhos: um dia de mergulho '
            'batismo nas melhores praias de Noronha, com equipamento completo e '
            'instrutor certificado acompanhando cada imersão.',
        tags: <String>['Mergulho', 'Praia', 'Vida marinha'],
      ),
    ];
  }

  Destination? findById(String id) {
    for (final destination in seed()) {
      if (destination.id == id) return destination;
    }
    return null;
  }

  /// Seed reviews shared across destination detail screens.
  List<Review> reviews() {
    return const <Review>[
      Review(
        author: 'Marina Alves',
        initials: 'MA',
        rating: 5.0,
        date: 'Maio 2026',
        comment:
            'Lugar dos sonhos! Cada dia parecia um cartão-postal. O roteiro '
            'sugerido pelo app encaixou tudo perfeitamente.',
        trip: 'Viagem em casal',
      ),
      Review(
        author: 'Pedro Nunes',
        initials: 'PN',
        rating: 4.5,
        date: 'Abril 2026',
        comment:
            'Experiência incrível e bem organizada. Só senti falta de mais '
            'tempo livre no fim da tarde para explorar por conta própria.',
        trip: 'Viagem em grupo',
      ),
      Review(
        author: 'Carla Dias',
        initials: 'CD',
        rating: 5.0,
        date: 'Março 2026',
        comment:
            'Superou as expectativas. Guias atenciosos, paisagens de tirar o '
            'fôlego e uma logística impecável do começo ao fim.',
        trip: 'Viagem em família',
      ),
    ];
  }

  /// Real async load; falls back to seed data if the network is unavailable.
  Future<List<Destination>> fetch() async {
    try {
      final models = await _service.fetchDestinations();
      if (models.isEmpty) return seed();
      return models.map((model) => model.toDomain()).toList();
    } catch (_) {
      return seed();
    }
  }
}
