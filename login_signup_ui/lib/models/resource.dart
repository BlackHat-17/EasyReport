class Resource {
     final String id;
     final String name;
     final String type;
     final String url;
     final String? region;

     Resource({
       required this.id,
       required this.name,
       required this.type,
       required this.url,
       this.region,
     });

     factory Resource.fromJson(Map<String, dynamic> json) {
       return Resource(
         id: json['id'],
         name: json['name'],
         type: json['type'],
         url: json['url'],
         region: json['region'],
       );
     }
   }