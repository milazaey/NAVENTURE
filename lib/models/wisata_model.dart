class Wisata {
  final String id;
  final String name;
  final String location;
  final String imageUrl;
  final double rating;
  final List<String> category;
  final String price;
  final String openHours;
  final String description;
  final String distance;
  final String mapsUrl;
  bool isFavorite; // <--- Tambahin ini (gak pake final biar bisa diubah)

  Wisata({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.rating,
    required this.category,
    required this.price,
    required this.openHours,
    required this.description,
    required this.distance,
    required this.mapsUrl,
    this.isFavorite = false,
  });
}

// Data Dummy buat ngetes tampilan
List<Wisata> mockWisata = [
  Wisata(
    id: '1',
    name: 'Kawah Wurung',
    location: 'Sempol, Bondowoso',
    imageUrl: 'assets/img/kawahwurung.jpg', // Pastiin file gambar ada di assets
    rating: 4.6,
    category: ['Dataran Tinggi'],
    price: '10.000',
    openHours: '08.00 - 16.00',
    distance: '64,2 km dari alun-alun',
    mapsUrl: 'https://maps.app.goo.gl/2W3XBmC6iaULuDxx8',
    description:
        '''   Nama "Wurung" dalam bahasa Jawa berarti "sesuatu yang gagal". Dinamakan demikian karena tempat ini merupakan kawah purba yang gagal meletus dan tidak memiliki air maupun api vulkanik, sehingga permukaannya justru tertutup oleh hamparan rumput hijau yang sangat luas.
    Kini, kawah ini lebih dikenal sebagai "Highland"-nya Bondowoso karena pemandangannya yang mirip dengan padang rumput di Selandia Baru. Keunikan utamanya adalah bukit-bukit kecil di tengah kawah yang sering dijuluki sebagai Bukit Teletubbies, menjadikannya spot favorit untuk camping dan fotografi.''',
  ),
  Wisata(
    id: '2',
    name: 'Sungai Kalipahit',
    location: 'Kalianyar, Bondowoso',
    imageUrl: 'assets/img/kalipahit.jpg',
    rating: 4.7,
    category: ['Air Terjun'],
    price: '5.000',
    openHours: '07.00 – 17.00',
    distance: '63,1 km dari alun-alun',
    mapsUrl: 'https://maps.app.goo.gl/DHcKzrgzAt1nnNoq8',
    description:
        '''   Sungai Kalipahit merupakan aliran air yang berasal langsung dari kawah Ijen. Sesuai namanya, air di sungai ini memiliki rasa pahit dan sangat asam karena kandungan sulfur serta belerang yang sangat tinggi, sehingga airnya berwarna kekuningan dan berbuih di beberapa bagian.
    Secara geologis, sungai ini menyajikan pemandangan dinding bebatuan yang eksotis hasil endapan mineral selama bertahun-tahun. Meskipun airnya tidak bisa digunakan untuk mandi atau minum, aroma belerang dan kontras warna antara air kuning dengan lumut hijau di sekitarnya memberikan kesan magis bagi siapa saja yang datang.''',
  ),
  Wisata(
    id: '3',
    name: 'Kawah Ilalang',
    location: 'Sempol, Bondowoso',
    imageUrl: 'assets/img/kawahilalang.jpg',
    rating: 4.5,
    category: ['Dataran Tinggi'],
    price: 'gratis',
    openHours: ' 06.00-17.00 ',
    distance: '63,7 km dari alun-alun',
    mapsUrl: 'https://maps.app.goo.gl/bBPz9k2U32Cwoq3VA',
    description:
        '''   Kawah Ilalang adalah sebuah lembah yang dikelilingi perbukitan di mana seluruh permukaannya ditumbuhi oleh tanaman ilalang atau alang-alang yang sangat lebat. Tempat ini sebenarnya merupakan bekas kawah tua yang sudah mati, namun keindahannya baru terpancar saat angin bertiup kencang dan menggoyangkan hamparan ilalang putih tersebut.
    Suasana di sini sangat tenang dan terasa seperti berada di film-film romantis. Waktu terbaik untuk berkunjung adalah saat pagi atau sore hari, di mana cahaya matahari akan menembus sela-sela ilalang, menciptakan gradasi warna perak dan emas yang sangat memanjakan mata.''',
  ),
  Wisata(
    id: '4',
    name: 'Bukit Jabal Kirmit',
    location: 'Jampit, Bondowoso',
    imageUrl: 'assets/img/bukitjabalkirmit.jpg',
    rating: 4.4,
    category: ['Dataran Tinggi'],
    price: '5.000',
    openHours: '06.00 – 18.00 ',
    distance: '70 km dari alun-alun',
    mapsUrl: 'https://maps.app.goo.gl/HM464LM9LadzqAn2A',
    description:
        '''   Bukit Jabal Kirmit terletak di kawasan Jampit dan sering kali disebut sebagai miniatur pegunungan di Eropa. Latar belakang tempat ini merupakan area padang rumput hijau yang luas yang digunakan sebagai tempat merumput bagi hewan ternak seperti kuda dan sapi milik penduduk setempat.
    Lokasinya yang berada di ketinggian memberikan suhu udara yang sangat sejuk dan sering kali diselimuti kabut tipis. Bagi para pelancong, mendaki bukit ini memberikan kepuasan tersendiri karena dari puncaknya, lo bisa melihat hamparan perkebunan kopi dan hutan pinus yang berjajar rapi di bawahnya.''',
  ),
  Wisata(
    id: '5',
    name: 'Taman Galuh',
    location: 'Ijen, Bondowoso',
    imageUrl: 'assets/img/tamangaluh.jpg',
    rating: 4.2,
    category: ['Dataran Tinggi'],
    price: '5.000',
    openHours: '07.00 – 17.00',
    distance: '65,4 km dari alun-alun',
    mapsUrl: 'https://maps.app.goo.gl/uowsTLEUXYKhPEv5A',
    description:
        '''   Taman Galuh dipercaya oleh masyarakat sekitar sebagai tempat peristirahatan putri dari zaman kerajaan Majapahit karena keindahan alamnya yang luar biasa. Berbeda dengan kawah lainnya, Taman Galuh menawarkan pemandangan bukit-bukit kecil yang dipenuhi bunga liar dan formasi batuan alami yang tersusun cantik.
    Secara visual, tempat ini memberikan kesan tenang dan asri dengan dominasi warna hijau yang segar. Pengunjung biasanya datang ke sini untuk mencari ketenangan dari hiruk-pikuk kota sambil menikmati udara pegunungan Ijen yang masih sangat murni.''',
  ),
  Wisata(
    id: '6',
    name: "Batu So'on",
    location: 'Cermee, Bondowoso',
    imageUrl: 'assets/img/batusoon.jpg',
    rating: 4.2,
    category: ['Situs Sejarah', 'Dataran Tinggi'],
    price: '5.000',
    openHours: '24 jam',
    distance: '43,3 km dari alun-alun',
    mapsUrl: 'https://maps.app.goo.gl/sZHATzRx6a9H38Em6',
    description:
        '''   Batu So'on sering dijuluki sebagai "Stonehenge" dari Bondowoso karena keberadaan batu-batu raksasa yang tersusun secara alami. Kata "So'on" dalam bahasa Madura berarti "disunggi" atau diletakkan di atas kepala, merujuk pada formasi batu besar yang bertumpuk-tumpuk secara ajaib tanpa bantuan manusia.
    Situs ini merupakan fenomena geologi yang terbentuk akibat erosi dan aktivitas vulkanik ribuan tahun silam. Selain nilai estetikanya yang tinggi untuk fotografi, tempat ini juga dianggap sakral dan menyimpan banyak cerita rakyat mengenai asal-usul batu raksasa tersebut.''',
  ),
  Wisata(
    id: '7',
    name: 'Sampean Baru',
    location: 'Koanyar, Bondowoso',
    imageUrl: 'assets/img/bendungansampeanbaru.jpg',
    rating: 4.4,
    category: ['Agro Wisata'],
    price: '5.000',
    openHours: '07.00 – 17.00',
    distance: '18,7 km dari alun-alun',
    mapsUrl: 'https://maps.app.goo.gl/yR6yqG6pzSBqyhh77',
    description:
        '''   Bendungan Sampean Baru merupakan proyek infrastruktur pengairan yang dibangun dengan desain arsitektur yang sangat ikonik. Struktur betonnya yang berjejer rapi dan simetris memberikan kesan megah, seolah-olah menyerupai bangunan kuil kuno namun dalam bentuk yang lebih modern.
    Selain fungsi utamanya sebagai sarana irigasi pertanian, bendungan ini telah menjadi destinasi wisata populer karena bentuk bangunannya yang sangat instagramable. Pantulan bayangan beton di permukaan air menciptakan pemandangan yang sangat dramatis, terutama saat matahari mulai terbenam.''',
  ),
  Wisata(
    id: '8',
    name: 'Kebun Kopi Jampit',
    location: 'Ijen, Bondowoso',
    imageUrl: 'assets/img/kebunkopijampit.jpg',
    rating: 4.9,
    category: ['Agro Wisata'],
    price: '5.000',
    openHours: '24 jam',
    distance: '31,2 km dari alun-alun',
    mapsUrl: 'https://maps.app.goo.gl/9q8U87haDwvqzQDW9',
    description:
        '''   Kebun Kopi Jampit adalah peninggalan era kolonial Belanda yang masih beroperasi hingga saat ini sebagai salah satu penghasil kopi Arabika terbaik di dunia. Kawasan ini memiliki latar belakang sejarah yang kuat dengan adanya rumah-rumah bergaya arsitektur Belanda (Guest House Jampit) yang masih terawat sangat baik.
    Mengunjungi kebun ini bukan sekadar melihat tanaman kopi, tapi juga merasakan suasana tempo dulu di tengah udara dingin pegunungan. Luasnya perkebunan dan kabut yang sering turun memberikan nuansa misterius sekaligus tenang bagi para pecinta kopi dan sejarah.''',
  ),
  Wisata(
    id: '9',
    name: 'Air Terjun Blawan',
    location: 'Ijen, Bondowoso',
    imageUrl: 'assets/img/airterjunblawan.jpg',
    rating: 4.4,
    category: ['Air Terjun'],
    price: '5.000',
    openHours: '05.00-18.00',
    distance: '56,9 km dari alun-alun',
    mapsUrl: 'https://maps.app.goo.gl/1FdkymUTum6nDZWo7?g_st=aw',
    description:
        '''   Air Terjun Blawan merupakan hilir dari aliran Sungai Kalipahit yang membawa air asam dari Kawah Ijen. Keunikan air terjun ini adalah debit airnya yang sangat besar dan warnanya yang kekuningan karena kandungan belerang, yang kemudian "menghilang" masuk ke dalam lubang tanah (sungai bawah tanah).
    Area di sekitar air terjun ini dikelilingi oleh tebing-tebing tinggi yang ditumbuhi tumbuhan tropis yang rimbun. Suara gemuruh air yang jatuh ke dalam lubang bawah tanah menciptakan suasana yang megah sekaligus mendebarkan bagi setiap pengunjung.''',
  ),
  Wisata(
    id: '10',
    name: 'Air Terjun Gentongan',
    location: 'Ijen, Bondowoso',
    imageUrl: 'assets/img/airterjungentongan.jpeg',
    rating: 4.1,
    category: ['Air Terjun'],
    price: '5.000',
    openHours: '07.00-17.00',
    distance: '56,6 km dari alun-alun',
    mapsUrl: 'https://maps.app.goo.gl/3KKG7bUKACsMWLkn7?g_st=aw',
    description:
        '''   Nama "Gentongan" diambil dari bentuk formasi batuan di sekitar air terjun yang menyerupai bentuk gentong atau tempayan air besar. Air yang mengalir di sini masih mengandung kadar belerang, sehingga bebatuan yang dilewatinya berubah warna menjadi kuning keemasan dan putih kristal.
    Lokasinya yang cukup tersembunyi membuat tempat ini terasa lebih privat dibandingkan wisata Ijen lainnya. Keindahan gradasi warna batu akibat reaksi kimia sulfur menjadikannya salah satu objek wisata edukasi geologi yang menarik di Bondowoso.''',
  ),
  Wisata(
    id: '11',
    name: 'Air Terjun Pulo Agung',
    location: 'Ijen, Bondowoso',
    imageUrl: 'assets/img/airterjunpuloagung.png',
    rating: 4.4,
    category: ['Air Terjun'],
    price: 'gratis',
    openHours: '24 jam',
    distance: '31,8 km dari alun-alun',
    mapsUrl: 'https://maps.app.goo.gl/59ejTm2gbDaeYNPy9?g_st=aw',
    description:
        '''   Air Terjun Pulo Agung terletak di kawasan terpencil yang menawarkan keindahan alam yang masih sangat alami dan perawan. Jatuhan airnya yang tinggi dan lurus kebawah memberikan kesan megah di tengah lembah hijau yang sangat subur.
    Karena aksesnya yang menantang, tempat ini sering dianggap sebagai "Hidden Gem" atau permata tersembunyi bagi para petualang. Latar belakang hutan yang lebat dan tebing yang menjulang tinggi membuat siapa pun yang datang merasa benar-benar menyatu dengan alam liar Bondowoso.''',
  ),
  Wisata(
    id: '12',
    name: 'Bukit Mahadewa',
    location: 'Curahdami, Bondowoso',
    imageUrl: 'assets/img/bukitmahadewa.jpg',
    rating: 4.5,
    category: ['Dataran Tinggi'],
    price: '10.000',
    openHours: '05.00 – 18.00',
    distance: '9,7 km dari alun-alun',
    mapsUrl: 'https://maps.app.goo.gl/U84fFnemqZJuxXNXA',
    description:
        '''   Bukit Mahadewa merupakan salah satu titik pandang terbaik di Bondowoso yang menawarkan panorama gugusan pegunungan Ijen dan Raung secara sekaligus. Nama "Mahadewa" sendiri disematkan karena keindahan pemandangannya yang dianggap sangat agung dan mempesona, seolah berada di negeri di atas awan saat kabut pagi menyelimuti lembah di bawahnya.
    Daya tarik utama tempat ini adalah gardu pandang ikonik yang menjorok ke arah jurang, memberikan sensasi adrenalin sekaligus latar foto yang dramatis dengan hamparan hutan pinus yang hijau. Selain itu, jalur trekking-nya yang menantang namun tetap ramah bagi pemula menjadikan bukit ini destinasi favorit bagi mereka yang ingin menikmati matahari terbit tanpa harus mendaki gunung yang terlalu tinggi.''',
  ),
  Wisata(
    id: '13',
    name: 'Labang Seng',
    location: 'Grujugan, Bondowoso',
    imageUrl: 'assets/img/labangseng.jpeg',
    rating: 4.4,
    category: ['Dataran Tinggi', 'Situs Sejarah'],
    price: 'gratis',
    openHours: '24 jam',
    distance: '64 km dari alun-alun',
    mapsUrl: 'https://maps.app.goo.gl/dUz82cbwfy4MHYqJ8',
    description:
        '''   Labang Seng dalam bahasa Madura berarti "Pintu Seng". Nama ini merujuk pada sejarah tempat ini yang dulunya merupakan kawasan perkebunan peninggalan era kolonial Belanda, di mana terdapat gerbang atau bangunan dengan penutup seng yang sangat ikonik pada masanya. Kini, lokasi tersebut telah bertransformasi menjadi destinasi wisata alam yang menawarkan pemandangan perbukitan hijau yang bergelombang dengan udara yang sangat sejuk.
    Daya tarik utama dari Labang Seng adalah panorama "Negeri di Atas Awan" yang bisa dinikmati saat pagi buta. Dari puncak bukitnya, pengunjung bisa melihat hamparan kabut putih yang menyelimuti lembah, dengan latar belakang pegunungan Ijen dan Raung yang berdiri gagah di kejauhan. Tempat ini menjadi spot favorit bagi para pengejar matahari terbit (sunrise) dan pecinta fotografi karena lanskapnya yang sangat luas dan memanjakan mata.''',
  ),
  Wisata(
    id: '14',
    name: 'Air Terjun Tancak Kembar',
    location: 'Pakem, Bondowoso',
    imageUrl: 'assets/img/tancakkembar.png',
    rating: 4.3,
    category: ['Air Terjun', 'Situs Sejarah'],
    price: '5.000',
    openHours: ' 07.00-15.00',
    distance: '21,8 km dari alun-alun',
    mapsUrl: 'https://maps.app.goo.gl/tVPQyA5rb4tJncKP9?g_st=aw',
    description:
        '''   Air Terjun Tancak Kembar terletak di ketinggian sekitar 1.100 meter di atas permukaan laut dan memiliki keunikan berupa dua aliran air terjun yang jatuh berdampingan dengan ketinggian sekitar 77 meter. Masyarakat setempat percaya bahwa kedua air terjun ini memiliki jenis kelamin, yakni "Laki-laki" di sisi kiri dan "Perempuan" di sisi kanan, serta konon pernah menjadi tempat pemandian Dewi Rengganis dari Kerajaan Majapahit agar awet muda.
    Selain legenda yang menyelimutinya, lokasi ini menawarkan pemandangan hutan lindung yang masih sangat asri dan rimbun. Perjalanan menuju lokasi akan melewati hamparan kebun kopi dan kakao yang luas, memberikan aroma khas pedesaan yang menenangkan. Suara gemuruh air yang jatuh dan hawa dingin yang menusuk tulang menjadikan tempat ini pelarian sempurna bagi siapa saja yang ingin merasakan kemurnian alam lereng Argopuro.''',
  ),
];
