import '../../domain/models/hotel.dart';
import '../../domain/models/review.dart';
import '../services/hotel_api_service.dart';

/// Repository exposing a SYNCHRONOUS seed of stays plus a real async fetch
/// backed by the API service.
class HotelRepository {
  HotelRepository({HotelApiService? service})
      : _service = service ?? HotelApiService();

  final HotelApiService _service;

  /// Instant, offline data used to render content immediately.
  List<Hotel> seed() {
    return const <Hotel>[
      Hotel(
        id: 'mirante',
        name: 'Mirante do Leme Resort',
        location: 'Leme, Rio de Janeiro',
        rating: 4.9,
        reviewCount: 1284,
        pricePerNight: 890,
        stars: 5,
        kind: 'Resort',
        distanceLabel: '450 m da praia',
        description:
            'Um refúgio à beira-mar com vista para a Baía de Guanabara. '
            'Piscina de borda infinita, spa premiado e gastronomia assinada '
            'por chef renomado tornam cada estadia inesquecível.',
        amenities: <Amenity>[
          Amenity.wifi,
          Amenity.pool,
          Amenity.breakfast,
          Amenity.spa,
          Amenity.beachAccess,
          Amenity.gym,
          Amenity.restaurant,
          Amenity.bar,
        ],
        rooms: <RoomType>[
          RoomType(
            name: 'Vista Mar Deluxe',
            description: 'Varanda privativa com vista para o oceano',
            pricePerNight: 890,
            capacity: 2,
            beds: '1 cama king',
          ),
          RoomType(
            name: 'Suíte Família',
            description: 'Espaço amplo com sala de estar integrada',
            pricePerNight: 1290,
            capacity: 4,
            beds: '1 king + 2 solteiro',
          ),
          RoomType(
            name: 'Bangalô Jardim',
            description: 'Acesso direto ao jardim tropical e piscina',
            pricePerNight: 1590,
            capacity: 3,
            beds: '1 king + sofá-cama',
          ),
        ],
      ),
      Hotel(
        id: 'alfama',
        name: 'Alfama Boutique Hotel',
        location: 'Alfama, Lisboa',
        rating: 4.7,
        reviewCount: 962,
        pricePerNight: 640,
        stars: 4,
        kind: 'Boutique',
        distanceLabel: '1,2 km do centro',
        description:
            'Charme histórico no bairro mais autêntico de Lisboa. Terraço com '
            'vista para o Tejo, decoração em azulejos originais e café da '
            'manhã com produtos locais servido no pátio.',
        amenities: <Amenity>[
          Amenity.wifi,
          Amenity.breakfast,
          Amenity.bar,
          Amenity.airConditioning,
          Amenity.roomService,
          Amenity.petFriendly,
        ],
        rooms: <RoomType>[
          RoomType(
            name: 'Quarto Clássico',
            description: 'Aconchegante, com detalhes em azulejo português',
            pricePerNight: 640,
            capacity: 2,
            beds: '1 cama queen',
          ),
          RoomType(
            name: 'Suíte Terraço',
            description: 'Terraço privativo com vista para o rio',
            pricePerNight: 980,
            capacity: 2,
            beds: '1 cama king',
          ),
        ],
      ),
      Hotel(
        id: 'andes',
        name: 'Andes Grand Hotel',
        location: 'Providencia, Santiago',
        rating: 4.6,
        reviewCount: 738,
        pricePerNight: 520,
        stars: 4,
        kind: 'Hotel',
        distanceLabel: '800 m do metrô',
        description:
            'Elegância urbana aos pés da cordilheira. Rooftop com piscina '
            'aquecida, academia 24h e adega com os melhores vinhos chilenos '
            'para degustação exclusiva dos hóspedes.',
        amenities: <Amenity>[
          Amenity.wifi,
          Amenity.pool,
          Amenity.gym,
          Amenity.parking,
          Amenity.restaurant,
          Amenity.airConditioning,
        ],
        rooms: <RoomType>[
          RoomType(
            name: 'Quarto Executivo',
            description: 'Vista para a cidade e escrivaninha de trabalho',
            pricePerNight: 520,
            capacity: 2,
            beds: '1 cama queen',
          ),
          RoomType(
            name: 'Suíte Cordilheira',
            description: 'Janelas panorâmicas para os Andes',
            pricePerNight: 760,
            capacity: 2,
            beds: '1 cama king',
          ),
        ],
      ),
      Hotel(
        id: 'noronha',
        name: 'Pousada Mar Azul',
        location: 'Vila dos Remédios, Noronha',
        rating: 4.8,
        reviewCount: 421,
        pricePerNight: 1180,
        stars: 4,
        kind: 'Pousada',
        distanceLabel: '300 m da Praia do Cachorro',
        description:
            'Uma pousada pé na areia em Fernando de Noronha. Chalés integrados '
            'à natureza, café da manhã regional e passeios de mergulho saindo '
            'da própria recepção.',
        amenities: <Amenity>[
          Amenity.wifi,
          Amenity.breakfast,
          Amenity.beachAccess,
          Amenity.bar,
          Amenity.airConditioning,
          Amenity.petFriendly,
        ],
        rooms: <RoomType>[
          RoomType(
            name: 'Chalé Standard',
            description: 'Cercado por vegetação nativa, calmo e reservado',
            pricePerNight: 1180,
            capacity: 2,
            beds: '1 cama queen',
          ),
          RoomType(
            name: 'Chalé Vista Mar',
            description: 'Rede na varanda e vista para o pôr do sol',
            pricePerNight: 1680,
            capacity: 3,
            beds: '1 king + solteiro',
          ),
        ],
      ),
      Hotel(
        id: 'serra',
        name: 'Vinhedos Serra Flat',
        location: 'Vale dos Vinhedos, RS',
        rating: 4.5,
        reviewCount: 356,
        pricePerNight: 430,
        stars: 3,
        kind: 'Flat',
        distanceLabel: '2,5 km das vinícolas',
        description:
            'Flats aconchegantes entre parreirais, perfeitos para uma escapada '
            'romântica. Lareira, cozinha equipada e uma taça de espumante de '
            'boas-vindas em cada chegada.',
        amenities: <Amenity>[
          Amenity.wifi,
          Amenity.breakfast,
          Amenity.parking,
          Amenity.petFriendly,
          Amenity.airConditioning,
        ],
        rooms: <RoomType>[
          RoomType(
            name: 'Studio Parreiral',
            description: 'Vista para os vinhedos e cozinha compacta',
            pricePerNight: 430,
            capacity: 2,
            beds: '1 cama queen',
          ),
          RoomType(
            name: 'Loft Duplex',
            description: 'Dois ambientes com lareira e mezanino',
            pricePerNight: 690,
            capacity: 4,
            beds: '1 king + 2 solteiro',
          ),
        ],
      ),
    ];
  }

  Hotel? findById(String id) {
    for (final hotel in seed()) {
      if (hotel.id == id) return hotel;
    }
    return null;
  }

  /// Seed reviews shared across hotel detail screens.
  List<Review> reviews() {
    return const <Review>[
      Review(
        author: 'Rafael Teixeira',
        initials: 'RT',
        rating: 5.0,
        date: 'Junho 2026',
        comment:
            'Atendimento impecável e quarto espaçoso. O café da manhã sozinho '
            'já vale a estadia. Voltaremos com certeza!',
        trip: 'Estadia de 4 noites',
      ),
      Review(
        author: 'Juliana Costa',
        initials: 'JC',
        rating: 4.5,
        date: 'Maio 2026',
        comment:
            'Localização perfeita, muito perto de tudo. A piscina é linda e o '
            'staff extremamente prestativo o tempo todo.',
        trip: 'Estadia de 2 noites',
      ),
      Review(
        author: 'André Lima',
        initials: 'AL',
        rating: 4.5,
        date: 'Abril 2026',
        comment:
            'Ótimo custo-benefício. Ambiente tranquilo e limpo, ideal para '
            'descansar. Recomendo o jantar no restaurante interno.',
        trip: 'Viagem a trabalho',
      ),
    ];
  }

  /// Real async load; falls back to seed data if the network is unavailable.
  Future<List<Hotel>> fetch() async {
    try {
      final models = await _service.fetchHotels();
      if (models.isEmpty) return seed();
      return models.map((model) => model.toDomain()).toList();
    } catch (_) {
      return seed();
    }
  }
}
