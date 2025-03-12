enum PriceFilterEnum {
  todos('Todos los productos'),
  menos50USD('Menos de 50 USD'),
  mas50USD('Más de 50 USD');

  final String label;

  const PriceFilterEnum(this.label);
}
