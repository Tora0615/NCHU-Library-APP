import 'package:flutter/material.dart';
import '../helpers/RemoveOverScrollRipple.dart';

final List<News> _latestNews = [
  News(title : '[活動快訊]',subtitle :'2021研究攻略坊，防疫也能自主學習做研究!'),
  News(title : '[徵才訊息]',subtitle :'[數位自造工坊]徵生活學習生'),
  News(title : '[一般公告]',subtitle :'微型課程在數位自造工坊開課囉~'),
  News(title : '[開閉館公告]',subtitle :'[閉館公告]110年2月28日國定假日，閉館一日'),
  News(title : '[活動快訊]',subtitle :'興閱坊《2020Openbook好書獎》得獎書展2/22~3/31'),
  News(title : '[多媒體中心訊息]',subtitle :'新年快樂 ! 年度排行榜更新 ｜2020年度 TOP100影片排行榜｜'),
  News(title : '[開閉館公告]',subtitle :'[閉館公告] 2/10-2/16春節閉館公告'),
  News(title : '[活動快訊]',subtitle :'蟲生．蟲畫：科學繪圖點圖作品展'),
  News(title : '[活動快訊]',subtitle :'第二波自助借書抽獎名單出爐~寒假不看書要幹嘛! 來參加寒假閱讀推廣活動吧!'),
  News(title : '[一般公告]',subtitle :'本學期畢業研究生請把握時間完成論文上傳!'),
];

final ScrollController _newsScrollController = ScrollController();

class News {
  final String title;
  final String subtitle;

  News({this.title, this.subtitle});
}


class LatestNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(  //外框
        decoration: BoxDecoration(
          color: Color(0xFFC7B7AF), //TAUPE
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Container(  //內部包起來+邊框
          margin: EdgeInsets.fromLTRB(10,25,10,0),
          child: Scrollbar(  //右部滑動條
            thickness: 5,
            radius: Radius.circular(15),
            controller: _newsScrollController,  //isAlwaysShown need
            isAlwaysShown: true,
            child: Container(  //把ListViewBuilder包起來，跟滑動條隔出距離
              margin: EdgeInsets.fromLTRB(5,0,15,0),
              child: ScrollConfiguration(  //覆蓋ListView預設設定用
                behavior: RemoveOverScrollRipple(),  //覆蓋ListView上下水波紋
                child: ListView.builder(
                  controller: _newsScrollController,
                  itemCount: _latestNews.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(  //消息條
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white70,
                          ),
                          child: ListTile(
                            onTap: (){
                              // TODO : Open Web & Inkwell
                              print('tap, $index');
                            },
                            trailing: Icon(Icons.keyboard_arrow_right),
                            title: Text(
                              '${_latestNews[index].title}',
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              '${_latestNews[index].subtitle}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Container(height: 8,),  //分隔線
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        )
    );
  }
}
