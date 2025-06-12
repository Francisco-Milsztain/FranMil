class Games 
{

  String title;
  String category;
  String posterUrl;
  String creator;
  int year;

  //Constructor
  Games(
    {
      required this.title,
      required this.category,
      required this.posterUrl,
      required this.creator,
      required this.year,
    }
  );

}

List<Games> listaJuegos =
[
  Games(
    title: 'Fortnite',
    category: 'Shooter',
    posterUrl: 'https://n4g.com/articles/wp-content/uploads/2023/03/Fortnite-Save-The-World-With-Fortnite-Logo.jpg',
    creator: 'Epic Games',
    year: 2017,
  ),

  Games(
    title: 'Minecraft',
    category: 'Survival',
    posterUrl: 'https://cloudfront-us-east-1.images.arcpublishing.com/infobae/EXPB4AGS2ZA7VKTZKFMVELDHQU.jpg',
    creator: 'Mojang Studios',
    year: 2009,
  ),

  Games(
    title: 'Rocket League',
    category: 'Sports',
    posterUrl: 'https://cdn1.epicgames.com/offer/9773aa1aa54f4f7b80e44bef04986cea/EGS_RocketLeague_PsyonixLLC_S3_2560x1440-18eac9b5df1028fdcd5bad480ab6b085',
    creator: 'Psyonix',
    year: 2015,
  ),

  Games(
    title: 'Terraria',
    category: 'Survival',
    posterUrl: 'https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/105600/header.jpg?t=1731252354',
    creator: 'Re-Logic',
    year: 2011,
  ),

  Games(
    title: 'Proyect Zomboid',
    category: 'Survival',
    posterUrl: 'https://blizzstoreperu.com/cdn/shop/products/maxresdefault_a2a501b4-33f5-4bd0-81c8-7ee78d577b96.jpg?v=1657912185',
    creator: 'The Indie Stone',
    year: 2013,
  ),

];