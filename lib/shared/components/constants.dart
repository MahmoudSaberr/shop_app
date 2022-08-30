
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

void signOut(context)
{
  CacheHelper.removeData(key: 'token',).then((value) {
    if(value)
    {
      navigateAndFinish(context, ShopLoginScreen(),);
    }
  });
}

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

//علشان لما اجيب التوكين في ال main قبل ما ابدأ الابلكيشن اسجله فيه
String token = '';