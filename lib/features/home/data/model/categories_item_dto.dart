import 'package:shopping_app/features/home/domain/entities/category_item_entity.dart';

class CategoryItemDto {
  String? slug;
  String? name;
  String? url;
  String? image;

  CategoryItemDto({this.slug, this.name, this.url, this.image});

  CategoryItemDto.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    name = json['name'];
    url = json['url'];
    image = json['image'];
  }

  CategoryItemEntity toEntity() =>
      CategoryItemEntity(slug: slug ?? "", name: name ?? " ");
}
