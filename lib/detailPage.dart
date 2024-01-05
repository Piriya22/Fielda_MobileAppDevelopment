import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'dataset.dart';
import 'additionalWeather.dart';

class DetailPage extends StatelessWidget {
  final Weather tomorrowTemp;
  final List<Weather> sevenDay;
  const DetailPage(this.tomorrowTemp, this.sevenDay);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030317),
      body: Column(
        children: [TomorrowWeather(tomorrowTemp), SevenDays(sevenDay)],
      ),
    );
  }
}

class TomorrowWeather extends StatelessWidget {
  final Weather tomorrowTemp;
  const TomorrowWeather(this.tomorrowTemp);
  @override
  Widget build(BuildContext context) {
    return GlowContainer(
      color: Color(0xff00A1FF),
      glowColor: Color(0xff00A1FF),
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 32, right: 30, left: 30, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                const Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                    Text(
                      " 7 days",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const Icon(Icons.more_vert, color: Colors.white)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.3,
                  height: MediaQuery.of(context).size.width / 2.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(tomorrowTemp.image ?? ""),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Tomorrow",
                      style: TextStyle(fontSize: 25, height: 0.1),
                    ),
                    Container(
                      height: 115,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GlowText(
                            tomorrowTemp.max.toString(),
                            style: const TextStyle(
                                fontSize: 100, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "/" + tomorrowTemp.min.toString() + "\u00B0",
                            style: TextStyle(
                                color: Colors.black54.withOpacity(0.5),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      " ${tomorrowTemp.name}",
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              right: 30,
              left: 30,
            ),
            child: Column(
              children: [
                const Divider(color: Colors.white),
                const SizedBox(
                  height: 10,
                ),
                additionalWeather(tomorrowTemp)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SevenDays extends StatelessWidget {
  final List<Weather> sevenDay;

  const SevenDays(this.sevenDay);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: sevenDay.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Color.fromARGB(255, 46, 45, 45),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sevenDay[index].day ?? "",
                      style: const TextStyle(fontSize: 20),
                    ),
                    Container(
                      width: 135,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image(
                            image: AssetImage(sevenDay[index].image ?? ""),
                            width: 40,
                          ),
                          const SizedBox(width: 15),
                          Text(
                            sevenDay[index].name ?? "",
                            style: const TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "+" + sevenDay[index].max.toString() + "\u00B0",
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "+" + sevenDay[index].min.toString() + "\u00B0",
                          style:
                              const TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
