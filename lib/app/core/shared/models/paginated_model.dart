// ignore_for_file: public_member_api_docs, sort_constructors_first
class Paginated<T> {
  List<T> itens;

  final bool nextPage;

  Paginated({
    required this.itens,
    required this.nextPage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': itens.map((x) => (x as dynamic)?.toMap()).toList(),
      'next_page': nextPage,
    };
  }

  factory Paginated.fromMap(Map<String, dynamic> map, T Function(Map<String, dynamic>) fromM) {
    return Paginated<T>(
      itens: map['data']
          .map<T>(
            (x) => fromM(x as Map<String, dynamic>),
          )
          .toList(),
      nextPage: map['next_page'] as bool,
    );
  }
}
