import 'package:flutter/material.dart';
import '../models/wisata_model.dart';
import '../utils/theme.dart';
import '../pages/main/detail_page.dart';

class WisataCard extends StatefulWidget {
  final Wisata wisata;
  const WisataCard(this.wisata, {super.key});

  @override
  State<WisataCard> createState() => _WisataCardState();
}

class _WisataCardState extends State<WisataCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(widget.wisata)),
        ).then((value) {
          setState(() {});
        });
      },
      child: Container(
        width: 250,
        height: 350,
        margin: const EdgeInsets.only(
          right: 20,
          bottom: 20,
          top: 20,
        ), // Tambahin bottom margin dikit biar shadow gak kepotong
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          // --- INI DIA TAMBAHAN SHADOW-NYA BOI ---
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.40,
              ), // Sengaja gue tebelin dikit jadi 0.15 biar lebih berasa
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, 8), // Geser bayangan ke bawah
            ),
          ],
          // --- BACKGROUND GAMBAR LO TETEP AMAN DI SINI ---
          image: DecorationImage(
            image: AssetImage(widget.wisata.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // --- ICON LOVE KEAJAIBAN ---
            Positioned(
              top: 15,
              right: 15,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.wisata.isFavorite = !widget.wisata.isFavorite;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withValues(alpha: 0.3),
                  ),
                  child: Icon(
                    widget.wisata.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: widget.wisata.isFavorite ? Colors.red : Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),

            // --- INFO DI BAWAH (NAMA & RATING) ---
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 80,
                width: double.infinity,
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black.withValues(alpha: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.wisata.name,
                      style: poppinsText.copyWith(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: whiteColor,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.wisata.location,
                              style: poppinsText.copyWith(
                                color: whiteColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.wisata.rating.toString(),
                              style: poppinsText.copyWith(
                                color: whiteColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
