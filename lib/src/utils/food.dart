class Food {
  String? image;
  String? name;
  String? barcode;
  String? description;
  bool? kind;

  Food({this.barcode, this.description, this.image, this.name,this.kind});

  Food.fromJson(Map<String, dynamic> json)
      : image = json['img'],
        barcode = json['barCode'],
        name = json['name'],
        description = json['desc'],
        kind = json['kind'];
}
