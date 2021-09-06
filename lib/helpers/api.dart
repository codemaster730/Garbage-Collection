import 'dart:convert';

import 'dart:math';

class Api {
  dynamic getApiData(String url) {
    String jsonDataAsString = '{}';
    var rng = new Random();
    switch (url) {
      case "/login":
        jsonDataAsString = '''
        {
          "id": "11",
          "name": "cCleaner",
          "phone": "8634939443423",
          "avatar": "https://randomuser.me/api/portraits/med/men/14.jpg",
          "gender": "male",
          "apiToken": "asdf12312e12e",
          "email": "ccleaner@gamil.com",
          "role": "collector",
          "location": {
            "address" : "天津市北辰区瑞景街道紫瑞园19号楼",
            "lat" : "39.211990891345074",
            "long" : "117.11940967351599"
          },
          "password": "123123123"
        }
        ''';
        break;
      case "/get_notification":
        jsonDataAsString = '''
        {
          "counts":"2",
          "list":[
            {
              "id":"123",
              "data":"You have a visit request from Antony Mark1",
              "created_at":"2020-03-01",
              "read_at":"true",
              "type":"NewOrder"
            },
            {
              "id":"124",
              "data":"Contract has been initiated by Steve Edge2 ",
              "created_at":"2020-03-02",
              "read_at":"true",
              "type":"NewOrder"
            },
            {
              "id":"125",
              "data":"You have a visit request from Antony Mar3k",
              "created_at":"2020-03-03",
              "type":"StatusChangedOrder"
            },
            {
              "id":"126",
              "data":"Contract has been initiated by Steve Edge4 ",
              "created_at":"2020-03-04",
              "read_at":"true",
              "type":"NewOrder"
            }
          ]
        }
        ''';
        break;
      case "/getAllData":
        jsonDataAsString = '''
        {
          "userid": "111",
          "lang": "en",
          "garbage_type":{
            "1":"Glass",
            "2":"Wood",
            "3":"Tiled concrete",
            "4":"Metal",
            "5":"Paper",
            "6":"Plastic"
          },
          "garbage_unit":{
            "1":"Bags",
            "2":"Bins"
          },
          "order_state":{
            "1":"已下单",
            "2":"当前订单",
            "3":"待支付订单",
            "4":"历史订单"
          }
        }
        ''';

        // print(jsonDataAsString);
        break;
      case "/getRecommendedOrderList":
        jsonDataAsString = '''
        {
          "userid": "111",
          "lang": "en",
          "list":[
            {
              "id": "3123",
              "title": "Order #112",
              "user": {
                "id": "22",
                "name": "pass",
                "phone": "123939443423",
                "avatar": "https://randomuser.me/api/portraits/med/men/15.jpg",
                "gender": "female",
                "email": "pass@gamil.com",
                "role": "user",
                "location": {
                  "address" : "天津市北辰区瑞景街道紫瑞园19号楼",
                  "lat" : "39.211990891345074",
                  "long" : "117.11940967351599"
                }
              },
              "location": {
                "address" : "天津市北辰区瑞景街道紫瑞园19号楼",
                "lat" : "39.211990891345074",
                "long" : "117.11940967351599"
              },
              "garbage": [
                {
                  "garbage_type_id": "2",
                  "garbage_unit_id": "1",
                  "garbage_amount": "34",
                  "est_price": "200"
                },
                {
                  "garbage_type_id": "1",
                  "garbage_unit_id": "1",
                  "garbage_amount": "123",
                  "est_price": "200"
                },
                {
                  "garbage_type_id": "3",
                  "garbage_unit_id": "1",
                  "garbage_amount": "43",
                  "est_price": "200"
                },
                {
                  "garbage_type_id": "4",
                  "garbage_unit_id": "1",
                  "garbage_amount": "23",
                  "est_price": "200"
                },
                {
                  "garbage_type_id": "1",
                  "garbage_unit_id": "2",
                  "garbage_amount": "63",
                  "est_price": "100"
                }
              ],
              "state_id": "1",
              "price": "244",
              "collector_id": "11",
              "customer_service": "",
              "review":"Great work",
              "order_time":"2021-02-03",
              "receiced_time":"2021-02-04",
              "confirmed_time":"2021-02-05",
              "images":[
                "https://source.unsplash.com/random/400x300?sig=1",
                "https://source.unsplash.com/random/400x300?sig=2",
                "https://source.unsplash.com/random/400x300?sig=3",
                "https://source.unsplash.com/random/400x300?sig=4"
              ]
            },
            {
              "id": "2123",
              "title": "Order #132",
              "user": {
                "id": "23",
                "name": "pass1",
                "phone": "2323939443423",
                "avatar": "https://randomuser.me/api/portraits/med/men/16.jpg",
                "gender": "male",
                "email": "pass1@gamil.com",
                "role": "user",
                "location": {
                  "address" : "天津市北辰区瑞景街道天津市第二儿童医院天津市",
                  "lat" : "117.11382531444251",
                  "long" : "39.20708095275562"
                }
              },
              "location": {
                "address" : "天津市北辰区瑞景街道天津市第二儿童医院天津市",
                "lat" : "39.20708095275562",
                "long" : "117.11382531444251"
              },
              "garbage": [
                {
                  "garbage_type_id": "2",
                  "garbage_unit_id": "1",
                  "garbage_amount": "12",
                  "est_price": "200"
                },
                {
                  "garbage_type_id": "1",
                  "garbage_unit_id": "2",
                  "garbage_amount": "22",
                  "est_price": "100"
                }
              ],
              "order_time":"2021-02-03",
              "receiced_time":"2021-02-04",
              "confirmed_time":"2021-02-05",
              "state_id": "2",
              "price": "132",
              "collector_id": "12",
              "customer_service": "",
              "review":"wwo Great work",
              "images":[
                "https://source.unsplash.com/random/400x300?sig=5",
                "https://source.unsplash.com/random/400x300?sig=6",
                "https://source.unsplash.com/random/400x300?sig=7",
                "https://source.unsplash.com/random/400x300?sig=8"
              ]
            },
            {
              "id": "2123",
              "title": "Order #312",
              "user": {
                "id": "23",
                "name": "pass1",
                "phone": "2323939443423",
                "avatar": "https://randomuser.me/api/portraits/med/men/16.jpg",
                "gender": "male",
                "email": "pass1@gamil.com",
                "role": "user",
                "location": {
                  "address" : "beijing/bing4",
                  "lat" : "23.2323",
                  "long" : "32.1511"
                }
              },
              "location": {
                "address" : "天津市北辰区瑞景街道首创·宝翠花都(东区)首创",
                "lat" : "39.19780568774204",
                "long" : "117.11486198820906"
              },
              "garbage": [
                {
                  "garbage_type_id": "2",
                  "garbage_unit_id": "1",
                  "garbage_amount": "12",
                  "est_price": "200"
                },
                {
                  "garbage_type_id": "1",
                  "garbage_unit_id": "2",
                  "garbage_amount": "22",
                  "est_price": "100"
                }
              ],
              "order_time":"2021-02-03",
              "receiced_time":"2021-02-04",
              "confirmed_time":"2021-02-05",
              "state_id": "3",
              "price": "132",
              "collector_id": "12",
              "customer_service": "",
              "review":"wwo Great work",
              "images":[
                "https://source.unsplash.com/random/400x300?sig=9",
                "https://source.unsplash.com/random/400x300?sig=10",
                "https://source.unsplash.com/random/400x300?sig=11",
                "https://source.unsplash.com/random/400x300?sig=12"
              ]
            },
            {
              "id": "111",
              "title": "Order #111",
              "user": {
                "id": "23",
                "name": "pass1",
                "phone": "2323939443423",
                "avatar": "https://randomuser.me/api/portraits/med/men/16.jpg",
                "gender": "male",
                "email": "pass1@gamil.com",
                "role": "user",
                "location": {
                  "address" : "beijing/bing4",
                  "lat" : "23.2323",
                  "long" : "32.1511"
                }
              },
              "location": {
                "address" : "天津市北辰区瑞景街道首创·宝翠花都(东区)首创",
                "lat" : "39.19783568774204",
                "long" : "117.11436198820906"
              },
              "garbage": [
                {
                  "garbage_type_id": "2",
                  "garbage_unit_id": "1",
                  "garbage_amount": "12",
                  "est_price": "200"
                },
                {
                  "garbage_type_id": "1",
                  "garbage_unit_id": "2",
                  "garbage_amount": "22",
                  "est_price": "100"
                }
              ],
              "order_time":"2021-02-03",
              "receiced_time":"2021-02-04",
              "confirmed_time":"2021-02-05",
              "state_id": "4",
              "price": "132",
              "collector_id": "12",
              "customer_service": "",
              "review":"wwo Great work",
              "images":[
                "https://source.unsplash.com/random/400x300?sig=2",
                "https://source.unsplash.com/random/400x300?sig=3",
                "https://source.unsplash.com/random/400x300?sig=6",
                "https://source.unsplash.com/random/400x300?sig=1"
              ]
            }
          ]
        }
        ''';
        break;
      case "/getRecentOrderList":
        jsonDataAsString = '''
        {
          "userid": "mainMenu",
          "user": "Welcome to ",
          "list":[
            {
              "id": "3123",
              "title": "Order #223",
              "user": {
                "id": "22",
                "name": "pass",
                "phone": "123939443423",
                "avatar": "https://randomuser.me/api/portraits/med/men/15.jpg",
                "gender": "female",
                "email": "pass@gamil.com",
                "role": "user",
                "location": {
                  "address" : "beijing/bing2",
                  "lat" : "23.323",
                  "long" : "32.511"
                }
              },
              "location": {
                "address" : "beijing/bing1",
                "lat" : "23.323",
                "long" : "32.511"
              },
              "garbage": [
                {
                  "garbage_type_id": "2",
                  "garbage_unit_id": "1",
                  "garbage_amount": "12",
                  "est_price": "200"
                },
                {
                  "garbage_type_id": "1",
                  "garbage_unit_id": "2",
                  "garbage_amount": "22",
                  "est_price": "100"
                }
              ],
              "order_time":"2021-02-03",
              "receiced_time":"2021-02-04",
              "confirmed_time":"2021-02-05",
              "state_id": "4",
              "price": "244",
              "collector_id": "11",
              "customer_service": "",
              "review":"Great work",
              "images":[
                "https://source.unsplash.com/random/400x300?sig=11",
                "https://source.unsplash.com/random/400x300?sig=2",
                "https://source.unsplash.com/random/400x300?sig=3",
                "https://source.unsplash.com/random/400x300?sig=4"
              ]
            },
            {
              "id": "2123",
              "title": "Order #443",
              "user": {
                "id": "23",
                "name": "pass1",
                "phone": "2323939443423",
                "avatar": "https://randomuser.me/api/portraits/med/men/16.jpg",
                "gender": "male",
                "email": "pass1@gamil.com",
                "role": "user",
                "location": {
                  "address" : "beijing/bing4",
                  "lat" : "23.2323",
                  "long" : "32.1511"
                }
              },
              "location": {
                "address" : "beijing/bing6",
                "lat" : "23.2323",
                "long" : "32.5311"
              },
              "garbage": [
                {
                  "garbage_type_id": "2",
                  "garbage_unit_id": "1",
                  "garbage_amount": "12",
                  "est_price": "200"
                },
                {
                  "garbage_type_id": "1",
                  "garbage_unit_id": "2",
                  "garbage_amount": "22",
                  "est_price": "100"
                }
              ],
              "order_time":"2021-02-03",
              "receiced_time":"2021-02-04",
              "confirmed_time":"2021-02-05",
              "state_id": "4",
              "price": "132",
              "collector_id": "12",
              "customer_service": "",
              "review":"wwo Great work",
              "images":[
                "https://source.unsplash.com/random/400x300?sig=9",
                "https://source.unsplash.com/random/400x300?sig=6",
                "https://source.unsplash.com/random/400x300?sig=7",
                "https://source.unsplash.com/random/400x300?sig=8"
              ]
            }
          ]
        }
        ''';
        break;
      default:
        return null;
        break;
    }
    return jsonDecode(jsonDataAsString);
  }
}
