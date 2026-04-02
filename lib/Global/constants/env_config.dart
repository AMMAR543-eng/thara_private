// enum Environment { dev, prod }
//
// class EnvConfig {
//   static late String baseUrl;
//   static late String webUrl;
//
//   static void init(Environment env) {
//     switch (env) {
//       case Environment.dev:
//         baseUrl = 'https://stage.tp.tharaco.sa/api/v1/';
//         webUrl = 'https://tharaco.sa';
//         break;
//
//       case Environment.prod:
//         baseUrl = 'https://tp.tharaco.sa/api/v1/';
//         webUrl = 'https://tharaco.sa';
//         break;
//     }
//   }
// }