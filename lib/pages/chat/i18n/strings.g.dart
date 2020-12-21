// Generated file. Do not edit.

import 'package:flutter/foundation.dart';
import 'package:fast_i18n/fast_i18n.dart';

const String _baseLocale = '';
String _locale = _baseLocale;
Map<String, Strings> _strings = {
  '': Strings.instance,
  'en': Strings
      .instance, // assume default locale is en, add a specific 'en' locale to remove this or add config.i18n.json
};

/// use this to get your translations, e.g. t.someKey.anotherKey
Strings get t {
  return _strings[_locale];
}

class LocaleSettings {
  /// use the locale of the device, fallback to default locale
  static Future<void> useDeviceLocale() async {
    _locale =
        await FastI18n.findDeviceLocale(_strings.keys.toList(), _baseLocale);
  }

  /// set the locale, fallback to default locale
  static void setLocale(String locale) {
    _locale =
        FastI18n.selectLocale(locale, _strings.keys.toList(), _baseLocale);
  }

  /// get the current locale
  static String get currentLocale {
    if (_locale == 'en') return '';
    return _locale;
  }

  /// get the base locale
  static String get baseLocale {
    return _baseLocale;
  }

  /// get the supported locales
  static List<String> get locales {
    return _strings.keys.toList();
  }
}

class Strings {
  static Strings _instance = Strings();
  static Strings get instance => _instance;

  StringsAuth get Auth => StringsAuth._instance;
  StringsDrawer get Drawer => StringsDrawer._instance;
  StringsSettings get Settings => StringsSettings._instance;
  StringsAbout get About => StringsAbout._instance;
  StringsFeed get Feed => StringsFeed._instance;
  StringsChat get Chat => StringsChat._instance;
  StringsGroups get Groups => StringsGroups._instance;
  StringsWallpapers get Wallpapers => StringsWallpapers._instance;
  StringsNotifications get Notifications => StringsNotifications._instance;
  String get app_name => 'Travelman';
  String get app_version => '1.0.0';
  String get about_us =>
      'Travelman is a community dedicated to traveling to connect people.';
  String get unknown_error => 'Oops, Something went Wrong!';
  StringsReport get Report => StringsReport._instance;
  StringsAdmin get Admin => StringsAdmin._instance;
}

class StringsAuth {
  static StringsAuth _instance = StringsAuth();
  static StringsAuth get instance => _instance;

  String get next => 'Дальше';
  String get email_user => 'У вас Email, Логин здесь!';
  String get email => 'Email';
  String get password => 'Пароль';
  String get login => 'Логин';
  String get phone_verification => 'Верификация телефона';
  String get enter_code => 'Введите код присланый вам ';
  String get didnt_recieve_code => 'Не получили код? ';
  String get resend => 'ОТПРАВИТЬ ЕЩЕ РАЗ';
  String get verify => 'ПОДТВЕРДИТЬ';
  String get posts => 'ПОСТЫ';
  String get followig => 'ПОДПИСАЛИСЬ';
  String get followers => 'ПОДПИСЧИКИ';
  String get register => 'Регистрация';
  String get name => 'Имя';
  String get status => 'Статус';
  String get add_valid_name => 'Введите настоящее Имя';
  String get select_gender => 'Пожалуйста выберите свой пол.';
  String get male_gender => 'Мужской';
  String get female_gender => 'Женский';
  String get accept_terms => 'Я принимаю все положения и условия';
  String get save => 'Сохранить';
  String get invalid_email => 'Неверный Email';
  String get short_pass_msg => 'Пароль должен содержать не менее 8 символов.';
  String get name_taken => 'Имя пользователя уже используется';
  String get invalid_phone => '*Пожалуйста, заполните все ячейки как следует';
  String get follow => 'Подписаться';
  String get following => 'Подписан(а)';
  String get message => 'Сообщение';
  String get login_first => 'Ой ёй, сначала залогиньтесь';
}

class StringsDrawer {
  static StringsDrawer _instance = StringsDrawer();
  static StringsDrawer get instance => _instance;

  String get groups => 'Группы';
  String get notifications => 'Уведомления';
  String get wallpapers => 'Обои';
  String get chats => 'Чаты';
  String get profile => 'Профиль';
  String get settings => 'Настройки';
  String get admin => 'Админ';
}

class StringsSettings {
  static StringsSettings _instance = StringsSettings();
  static StringsSettings get instance => _instance;

  String get title => 'Настройки';
  String get account => 'Аккаунт';
  String get edit_profile => 'Редактировать профиль';
  String get online_status => 'Онлайн Статус';
  String get online_description =>
      'Кто угодно может видеть, когда вы в последний раз были в сети';
  String get logout => 'Выйти';
  String get notifications => 'Уведомления';
  String get direct_msgs => 'Директ';
  String get direct_msgs_descr => 'Получать все уведомления с директа';
  String get groups_msgs => 'Сообщения группы';
  String get groups_msgs_desc => 'Получить все уведомления группы';
  String get about => 'О нас';
}

class StringsAbout {
  static StringsAbout _instance = StringsAbout();
  static StringsAbout get instance => _instance;

  String get title => 'О нас';
  String get about_app => 'О приложении';
  String get rate_us => 'Оценить';
  String get eula => 'Соглашение';
  String get privacy_policy => 'Политика Конфиденциальности';
}

class StringsFeed {
  static StringsFeed _instance = StringsFeed();
  static StringsFeed get instance => _instance;

  String get title => 'Лента';
  String get post => 'Пост';
  String get newest => 'Новые';
  String get gallery => 'Галерея';
  String get story => 'Сторис';
  String get my_posts => 'Мои посты';
  String get favorite => 'Избранное';
  String get Announcement => 'Объявление';
  String get what_on_mind => 'О чем думаете?';
  String get report => 'Отчет';
  String get likes => 'Нравится';
  String get comments => 'Комментарии';
  String get create_post => 'Создать пост';
  String get share => 'Поделиться';
  String get edit => 'Редактировать';
  String get delete => 'Удалить';
  String get read_more => '...Читать дальше';
  String get type_comment => 'Ваш комментарий...';
  String get not_allowed_comment => 'Извините! Вам не разрешено комментировать';
  String get comment_remove_confirm =>
      'Вы уверены, что хотите удалить этот комментарий?';
  String get reply => 'Ответить';
  String get replies => 'Ответы';
}

class StringsChat {
  static StringsChat _instance = StringsChat();
  static StringsChat get instance => _instance;

  String get title => 'Чаты';
  String get online_users => 'ОНЛАЙН-ПОЛЬЗОВАТЕЛИ';
  String get recent_chats => 'ПОСЛЕДНИЕ ЧАТЫ';
  String get block => 'Блок';
  String get unblock => 'Разблок';
  String get remove_conversation => 'Удалить чат';
  String get message => 'Сообщение...';
  String get cannot_chat_with_user =>
      'Сожалеем! Вы не можете общаться с этим пользователем';
  String get msg_remove_confirm => 'Вы уверены, что хотите удалить сообщение?';
  String get online => 'В сети';
  String get typing => 'Печатает...';
  String get img_msg => 'Сообщение картинкой';
  String get voice_msg => 'Голосовое сообщение';
}

class StringsGroups {
  static StringsGroups _instance = StringsGroups();
  static StringsGroups get instance => _instance;

  String get title => 'Группы';
  String get create_group => 'Создать группу';
  String get members => 'Участники';
  String get message => 'Сообщение...';
  String get notifications => 'Уведомление';
  String get on => 'Вкл';
  String get off => 'Выкл';
  String get edit => 'Редактировать группу';
  String get save => 'Сохранить';
  String get leave => 'Выйти из группы';
  String get group_name => 'Имя Группы';
  String get join => 'Войти';
  String get remove_member => 'Удалить участника';
  String get block => 'Блок';
  String get unblock => 'Разблок';
  String get admin => 'Админ';
}

class StringsWallpapers {
  static StringsWallpapers _instance = StringsWallpapers();
  static StringsWallpapers get instance => _instance;

  String get newest => 'Новые';
  String get trending => 'В Тренде';
  String get favorite => 'Избранное';
  String get downloaded => 'Самое скачанное';
  String get categories => 'Категории';
  String get add_wallpaper => 'Добавить обои';
  String get wall_name => 'Название обоев';
  String get category => 'Категории';
  String get upload => 'Загрузить';
  String get home => 'Домой';
  String get lock => 'Закрыть';
  String get both => 'Оба';
  String get set_as_wallpaper => 'Установить как обои';
  String get wallpaper_set => 'Обои установлены';
  String get failed_to_upload => 'Ой ёй! Ошибка загрузки. Повторите попытку.';
  String get upload_finished => 'Загрузка завершена';
  String get no_img_selected => 'Изображение не выбрано';
}

class StringsNotifications {
  static StringsNotifications _instance = StringsNotifications();
  static StringsNotifications get instance => _instance;

  String get title => 'Уведомления';
  String get likes_post => 'Нравится ваш пост';
  String get start_following => 'Подписаться';
  String get commented_post => 'Комментировать ваш пост';
  String get replied => 'Ответил на ваш комментарий';
  String get liked_comment => 'Отозвался на ваш комментарий';
  String get sent_msg => 'Выслал вам сообщение';
}

class StringsReport {
  static StringsReport _instance = StringsReport();
  static StringsReport get instance => _instance;

  String get title => 'Отчет';
  String get desc => 'Мы удалили ваш пост потому что: ';
  String get report_reasons =>
      '⚫️ Секс. контент. \n\n⚫️ Насильственный или отторгающий контент. \n\n⚫️ Контент с оскорбления на почве ненависти. \n\n⚫️Спам или вводящий в заблуждение контент. ';
  String get note => 'Мы не уведомим пользователя если вы это сделаете.';
  String get thanks =>
      'Мы проверим ваш запрос, спасибо за помощь в улучшении нашего сообщества';
}

class StringsAdmin {
  static StringsAdmin _instance = StringsAdmin();
  static StringsAdmin get instance => _instance;

  String get title => 'Админ';
  String get posts => 'Отчитанные Посты';
}
