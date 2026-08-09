///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsDe extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsDe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.de,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <de>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsDe _root = this; // ignore: unused_field

	@override 
	TranslationsDe $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsDe(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsAboutDe about = _TranslationsAboutDe._(_root);
	@override late final _TranslationsAchievementsDe achievements = _TranslationsAchievementsDe._(_root);
	@override late final _TranslationsArtistsDe artists = _TranslationsArtistsDe._(_root);
	@override late final _TranslationsAuthDe auth = _TranslationsAuthDe._(_root);
	@override late final _TranslationsCommonDe common = _TranslationsCommonDe._(_root);
	@override late final _TranslationsErrorsDe errors = _TranslationsErrorsDe._(_root);
	@override late final _TranslationsEventsDe events = _TranslationsEventsDe._(_root);
	@override late final _TranslationsNotificationsDe notifications = _TranslationsNotificationsDe._(_root);
	@override late final _TranslationsOnboardingDe onboarding = _TranslationsOnboardingDe._(_root);
	@override late final _TranslationsPrivacyDe privacy = _TranslationsPrivacyDe._(_root);
	@override late final _TranslationsProfileDe profile = _TranslationsProfileDe._(_root);
	@override late final _TranslationsSettingsDe settings = _TranslationsSettingsDe._(_root);
	@override late final _TranslationsStatsDe stats = _TranslationsStatsDe._(_root);
	@override late final _TranslationsUpdateDe update = _TranslationsUpdateDe._(_root);
}

// Path: about
class _TranslationsAboutDe extends TranslationsAboutEn {
	_TranslationsAboutDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get about => 'Über';
	@override String get createdBy => 'Erstellt von';
	@override String get version => 'Version';
	@override String get versionHistory => 'Versionsverlauf';
	@override String get about_intro1 => 'Als Konzertliebhaber habe ich EvntTrackr ursprünglich für meinen eigenen Bedarf entwickelt. Schluss mit der mühsamen Verwaltung von Tabellenkalkulationen, nur noch eine einfache und zentrale Erfahrung.';
	@override String get about_intro2 => 'Überzeugt davon, dass die App auch für andere Enthusiasten nützlich sein könnte, habe ich beschlossen, sie mit Ihnen zu teilen.';
	@override String get about_support_title => 'Unterstützen Sie die Entwicklung';
	@override String get about_feedback_text => 'Ihr Feedback ist wertvoll! Zögern Sie nicht, mir Ihre Gedanken mitzuteilen:';
	@override String get about_email_tooltip => 'E-Mail senden';
	@override String get about_instagram_tooltip => 'Auf Instagram folgen';
	@override String get about_donation_text => 'Eine kleine Geste für ein großes Projekt. Wenn Sie möchten, können Sie mich mit einem Kaffee unterstützen! ☕';
	@override String get about_kofi_button => 'Buy me a coffee';
	@override String get about_paypal_button => 'Spenden';
	@override String get about_see_whatsnew => 'Was ist neu?';
	@override String get rate_us => 'App bewerten';
}

// Path: achievements
class _TranslationsAchievementsDe extends TranslationsAchievementsEn {
	_TranslationsAchievementsDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get achievements_firstStep => 'Erster Schritt';
	@override String get achievements_firstStepDescription => 'Protokollieren Sie Ihre erste Veranstaltung.';
	@override String get achievements_rookieCollector => 'Anfänger-Sammler';
	@override String get achievements_rookieCollectorDescription => 'Nimm einen Künstler auf';
	@override String get achievements_musicCritic => 'Musikkritiker';
	@override String get achievements_musicCriticDescription => 'Kommt bald';
	@override String get achievements_curious => 'Neugierig';
	@override String get achievements_curiousDescription => 'Besuche deine Statistikseite';
	@override String get achievements_regular => 'Stammgast';
	@override String get achievements_regularDescription => '10 Veranstaltungen protokollieren.';
	@override String get achievements_pillar => 'Säule';
	@override String get achievements_pillarDescription => '25 Veranstaltungen protokollieren.';
	@override String get achievements_headliner => 'Headliner';
	@override String get achievements_headlinerDescription => '50 Veranstaltungen protokollieren.';
	@override String get achievements_musicPokedex => 'Musik-Pokédex';
	@override String get achievements_musicPokedexDescription => 'Besuchen Sie Veranstaltungen mit 50 verschiedenen Künstlern.';
	@override String get achievements_trueFan => 'Wahrer Fan';
	@override String get achievements_trueFanDescription => 'Sehen Sie denselben Künstler bei 5 verschiedenen Veranstaltungen.';
	@override String get achievements_superFan => 'Super-Fan';
	@override String get achievements_superFanDescription => 'Sehen Sie denselben Künstler bei 10 verschiedenen Veranstaltungen.';
	@override String get achievements_dieHardFan => 'Hardcore-Fan';
	@override String get achievements_dieHardFanDescription => 'Sehen Sie denselben Künstler bei 15 verschiedenen Veranstaltungen.';
	@override String get achievements_loyal => 'Loyal';
	@override String get achievements_loyalDescription => 'Kommt bald';
	@override String get achievements_marathoner => 'Marathonläufer';
	@override String get achievements_marathonerDescription => 'Kommt bald';
	@override String get achievements_eclectic => 'Eklektisch';
	@override String get achievements_eclecticDescription => 'Besuchen Sie ein Konzert und ein Festival.';
	@override String get achievements_discoverer => 'Entdecker';
	@override String get achievements_discovererDescription => 'Kommt bald';
	@override String get achievements_globetrotter => 'Weltenbummler';
	@override String get achievements_globetrotterDescription => 'Besuchen Sie Veranstaltungen an mindestens 5 verschiedenen Orten.';
	@override String get achievements_archaeologist => 'Archäologe';
	@override String get achievements_archaeologistDescription => 'Protokollieren Sie eine Veranstaltung von vor mehr als 5 Jahren.';
	@override String get achievements_nightOwl => 'Nachteule';
	@override String get achievements_nightOwlDescription => 'Registriere eine Veranstaltung zwischen 0 und 6 Uhr';
	@override String get achievements_oops => 'Hoppla';
	@override String get achievements_oopsDescription => 'Löscht ein Ereignis.';
	@override String get achievements_summerFest => 'Sommerfest';
	@override String get achievements_summerFestDescription => 'Kommt bald';
	@override String get achievements_liveLegend => 'Live-Legende';
	@override String get achievements_liveLegendDescription => '100 Veranstaltungen protokollieren.';
	@override String get achievements_pioneer => 'Pionier';
	@override String get achievements_pioneerDescription => 'Nehmen Sie an der EvntTrackr-Beta teil.';
	@override String get achievements_venueRegular => 'Der Stammgast';
	@override String get achievements_venueRegularDescription => 'Besuche 5 Veranstaltungen am selben Ort.';
	@override String get achievements_venuePillar => 'Säule des Hauses';
	@override String get achievements_venuePillarDescription => 'Besuche 10 Veranstaltungen am selben Ort';
	@override String get achievements_venueLegend => 'Legende des Hauses';
	@override String get achievements_venueLegendDescription => 'Besuche 15 Veranstaltungen am selben Ort';
	@override String get rarity_common => 'Gewöhnlich';
	@override String get rarity_uncommon => 'Ungewöhnlich';
	@override String get rarity_rare => 'Selten';
	@override String get rarity_epic => 'Episch';
	@override String get rarity_legendary => 'Legendär';
}

// Path: artists
class _TranslationsArtistsDe extends TranslationsArtistsEn {
	_TranslationsArtistsDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get artist => 'Künstler';
	@override String get artists => 'Künstler';
	@override String get addArtist => 'Künstler hinzufügen';
	@override String get viewArtist => 'Künstler ansehen';
	@override String get rateArtist => 'Künstler bewerten';
	@override String get performanceRating => 'Performance';
	@override String get setlistRatingLabel => 'Setlist';
	@override String get soundQualityRating => 'Tonqualität';
	@override String get globalReview => 'Globale Bewertung';
	@override String get noArtistsForEvent => 'Keine Künstler für dieses Ereignis.';
	@override String get headliner => 'Headliner';
	@override String get ratingSaved => 'Bewertung erfolgreich gespeichert';
	@override String get artistSortOrderHeadliner => 'Headliner';
	@override String get artistSortOrderAZ => 'A-Z';
	@override String get artistSortOrderZA => 'Z-A';
}

// Path: auth
class _TranslationsAuthDe extends TranslationsAuthEn {
	_TranslationsAuthDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get signIn => 'Anmelden';
	@override String get signUp => 'Registrieren';
	@override String get dontHaveAccount => 'Ich habe kein Konto';
	@override String get alreadyHaveAccount => 'Ich habe bereits ein Konto';
	@override String get forgotPassword => 'Passwort vergessen?';
	@override String get pleaseEnterYourEmail => 'Gib deine E-Mail-Adresse ein';
	@override String get passwordResetLinkSent => 'Ein Link zum Zurücksetzen wurde dir per E-Mail gesendet';
	@override String get email => 'E-Mail';
	@override String get password => 'Passwort';
	@override String get username => 'Benutzername';
	@override String get confirmPassword => 'Passwort bestätigen';
	@override String get welcome => 'Willkommen bei EvntTrackr 2.3.0!';
	@override String get welcomedescription => 'Vielen Dank, dass Sie EvntTrackr nutzen! Ich bin mit ganzem Herzen dabei, eine App zu entwickeln, die Ihnen genauso gut gefällt wie mir. Die App befindet sich noch in der Testphase: Ihr Feedback ist für die Verbesserung der App unerlässlich! Zögern Sie nicht, mir Ihr Feedback über die Seite „Über uns” mitzuteilen. Viel Spaß beim Entdecken!';
	@override String get whatsnew => 'Was ist neu?';
	@override String get moretocome => 'Mehr zu kommen!';
	@override String get alwaysimproving => 'EvntTrackr wird ständig verbessert und bietet neue Möglichkeiten, deine Events zu genießen. Zögere nicht, mir dein Feedback über die „Über“-Seite mitzuteilen 💪';
	@override String get letsgo => 'Los geht\'s!';
	@override String get new1 => 'Online-Event-Suche';
	@override String get new1description => 'Finde deine Events noch einfacher mit unserer neuen Online-Suche, die externe Datenbanken integriert!';
	@override String get new2 => 'Verpasse nichts mehr';
	@override String get new2description => 'Aktiviere Event-Erinnerungen mit neuen lokalen Benachrichtigungen, damit du immer pünktlich bist.';
	@override String get new3 => 'Ein stilvolles Profil';
	@override String get new3description => 'Entdecke eine verbesserte Benutzeroberfläche für deine Profil-, Statistik- und Erfolgsseiten. Schöner und übersichtlicher!';
	@override String get acceptPrivacyPolicy => 'Ich habe die Datenschutzbestimmungen gelesen und akzeptiere sie';
	@override String get confirmationEmailSent => 'Bestätigungs-E-Mail gesendet';
}

// Path: common
class _TranslationsCommonDe extends TranslationsCommonEn {
	_TranslationsCommonDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Abbrechen';
	@override String get send => 'Senden';
	@override String get close => 'Schließen';
	@override String get reset => 'Zurücksetzen';
	@override String get create => 'Erstellen';
	@override String get update => 'Aktualisieren';
	@override String get save => 'Speichern';
	@override String get delete => 'Löschen';
	@override String get next => 'Weiter';
	@override String get add => 'Hinzufügen';
	@override String get search => 'Meine Events filtern...';
	@override String get today => 'Heute';
	@override String get tomorrow => 'Morgen';
	@override String inDays({required Object n}) => 'In ${n} Tagen';
	@override String dateRange({required Object startDate, required Object endDate}) => 'Vom ${startDate} bis ${endDate}';
	@override String pageOutOfTotal({required Object currentPage, required Object totalPages}) => 'Seite ${currentPage} von ${totalPages}';
	@override String get noDataAvailable => 'Keine Daten verfügbar';
	@override String get seeAll => 'Alle anzeigen';
	@override String get total => 'Gesamt';
	@override String get rank => '#';
	@override String get seen => 'Gesehen';
	@override String get thisYear => 'Dieses Jahr';
}

// Path: errors
class _TranslationsErrorsDe extends TranslationsErrorsEn {
	_TranslationsErrorsDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get invalidPrice => 'Bitte geben Sie einen gültigen Preis ein.';
	@override String get pleaseEnterAUsername => 'Bitte geben Sie einen Benutzernamen ein';
	@override String get pleaseEnterAPassword => 'Bitte geben Sie ein Passwort ein';
	@override String get pleaseConfirmYourPassword => 'Bitte bestätigen Sie Ihr Passwort';
	@override String get loginerror => 'Fehler beim Anmelden versuchen.';
	@override String get eventCreateError => 'Fehler beim Erstellen der Veranstaltung';
	@override String get eventUpdateError => 'Fehler beim Aktualisieren der Veranstaltung';
	@override String get artistAddError => 'Fehler beim Hinzufügen des Künstlers';
	@override String get locationAddError => 'Fehler beim Hinzufügen des Ortes';
	@override String get errorDeletingEvent => 'Fehler beim Löschen des Ereignisses';
	@override String get error => 'Fehler';
	@override String get errorDetails => 'Fehler';
	@override String get errorUpdatingHeadlinerStatus => 'Fehler beim Aktualisieren des Headliner-Status.';
	@override String get pleaseAcceptPrivacyPolicy => 'Bitte akzeptieren Sie die Datenschutzbestimmungen, um fortzufahren';
	@override String get passwordsDoNotMatch => 'Die Passwörter stimmen nicht überein';
	@override String get passwordTooShort => 'Das Passwort muss mindestens 6 Zeichen lang sein';
	@override String get passwordComplexity => 'Das Passwort muss mindestens eine kleine, eine große und eine Zahl enthalten';
	@override String get pleaseEnterNewPassword => 'Bitte geben Sie ein neues Passwort ein';
	@override String get nameRequired => 'Name erforderlich';
	@override String get locationRequired => 'Bitte wählen Sie einen Ort aus';
	@override String get dateRequired => 'Datum erforderlich';
	@override String get requiredField => 'Erforderlich';
	@override String get invalidNumber => 'Ungültige Nummer';
}

// Path: events
class _TranslationsEventsDe extends TranslationsEventsEn {
	_TranslationsEventsDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get events => 'Events';
	@override String get eventname => 'Veranstaltungsname';
	@override String get location => 'Ort';
	@override String get start => 'Start';
	@override String get end => 'Ende';
	@override String get datetime => 'Datum und Uhrzeit';
	@override String get gotmyticket => 'Ich habe mein Ticket';
	@override String get price => 'Preis';
	@override String get eventtype => 'Veranstaltungstyp';
	@override String get festival => 'Festival';
	@override String get concert => 'Concert';
	@override String get createevent => 'Veranstaltung erstellen';
	@override String get editEvent => 'Veranstaltung bearbeiten';
	@override String get editevent => 'Event bearbeiten';
	@override String get eventCreatedSuccess => 'Veranstaltung erfolgreich erstellt!';
	@override String get eventUpdatedSuccess => 'Veranstaltung erfolgreich aktualisiert!';
	@override String get eventDeletedSuccessfully => 'Ereignis erfolgreich gelöscht.';
	@override String get noEventDetailsFound => 'Keine Details für dieses Ereignis gefunden.';
	@override String get deleteEvent => 'Ereignis löschen';
	@override String get confirmDeletion => 'Löschung bestätigen';
	@override String get confirmDeleteEventMessage => 'Sind Sie sicher, dass Sie dieses Ereignis löschen möchten? Diese Aktion ist irreversibel.';
	@override String get event_ongoing => 'Laufend';
	@override String get upcoming => 'Anstehend';
	@override String get past => 'Vergangen';
	@override String get bookmarked => 'Gespeichert';
	@override String get noupcoming => 'Keine anstehenden Veranstaltungen.';
	@override String get nopast => 'Keine vergangenen Veranstaltungen.';
	@override String get nobookmarked => 'Keine gespeicherten Veranstaltungen.';
	@override String get addToUpcoming => 'Als gekauft markieren?';
	@override String get addToUpcomingInfo => 'Dadurch wird die Veranstaltung auf die Registerkarte "Anstehend" verschoben.';
	@override String get eventAddedToUpcoming => 'Veranstaltung zur Liste "Anstehend" hinzugefügt';
	@override String get priceWithCurrency => 'Preis (€)';
	@override String get ticketPriceOptional => 'Ticketpreis (optional)';
	@override String get searchPlaceholder => 'Nach Event, Künstler suchen...';
	@override String get filterAroundMe => 'In meiner Nähe';
	@override String get filterGenre => 'Genre';
	@override String get filterDate => 'Nach Datum filtern';
	@override String get unknownLocation => 'Unbekannter Ort';
	@override String get artistsIncluded => 'Künstler enthalten';
	@override String get artistIncluded => 'Künstler enthalten';
	@override String get noEventDetailsFoundDesc => 'Keine Sorge, Sie können es manuell erstellen! (Veranstaltungsort und Künstler werden vorgeschlagen)';
	@override String get createManually => 'Manuell erstellen';
	@override String get searchOnlineTitle => 'Online-Suche';
	@override String get searchBetaDesc => 'Funktion in Beta: Einige Ereignisse werden möglicherweise nicht gefunden.';
}

// Path: notifications
class _TranslationsNotificationsDe extends TranslationsNotificationsEn {
	_TranslationsNotificationsDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override List<String> get titles => [
		'Erinnerung!',
		'Bald ist es soweit!',
		'Mach dich bereit!',
		'Bevorstehendes Event!',
	];
	@override String withTicket({required Object name, required Object time}) => '${name} findet in ${time} statt. Vergiss dein Ticket nicht!';
	@override String withoutTicket({required Object name, required Object time}) => '${name} findet in ${time} statt. Hast du dein Ticket schon?';
	@override String details({required Object date, required Object location}) => 'Datum: ${date} • Ort: ${location}';
	@override String get time1Week => 'einer Woche';
	@override String get time24h => '24 Stunden';
	@override String get channelName => 'Event-Erinnerungen';
	@override String get channelDesc => 'Benachrichtigungen, die dich an bevorstehende Events erinnern';
}

// Path: onboarding
class _TranslationsOnboardingDe extends TranslationsOnboardingEn {
	_TranslationsOnboardingDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get welcomeTitle => 'Willkommen!';
	@override String get welcomeSubtitle => 'Beginnen wir damit, Ihre Einstellungen für ein optimales Erlebnis festzulegen.';
	@override String get languageTitle => 'Sprache';
	@override String get languageSubtitle => 'Wählen Sie Ihre bevorzugte Sprache';
	@override String get themeTitle => 'Design';
	@override String get themeSubtitle => 'Passen Sie das Erscheinungsbild der App an';
	@override String get dateFormatTitle => 'Datumsformat';
	@override String get dateFormatSubtitle => 'Wie möchten Sie Daten am liebsten lesen?';
	@override String get readyTitle => 'Alles bereit!';
	@override String get readySubtitle => 'Sie müssen sich nur noch anmelden oder registrieren, um loszulegen!';
	@override String get next => 'Weiter';
	@override String get start => 'Starten';
	@override String get back => 'Zurück';
	@override String get notificationsTitle => 'Benachrichtigungen';
	@override String get notificationsSubtitle => 'Verpasse keines deiner Events';
}

// Path: privacy
class _TranslationsPrivacyDe extends TranslationsPrivacyEn {
	_TranslationsPrivacyDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get privacyPolicy => 'Datenschutzbestimmungen';
	@override String get privacyPolicyTitle => 'Datenschutzbestimmungen';
	@override String get privacyPolicyContent => 'Ihre Privatsphäre ist uns wichtig.';
	@override String get privacy_intro_title => '1. Einführung';
	@override String get privacy_intro_body => 'EvntTrackr verpflichtet sich, Ihre personenbezogenen Daten in Übereinstimmung mit der Datenschutz-Grundverordnung (DSGVO) zu schützen. Diese Richtlinie erklärt, wie wir Ihre Informationen sammeln, verwenden und schützen.';
	@override String get privacy_data_collected_title => '2. Erhobene Daten';
	@override String get privacy_data_collected_body => 'Um EvntTrackr zu nutzen, müssen Sie ein Konto mit einer E-Mail-Adresse und einem Passwort erstellen. Innerhalb der App können Sie Veranstaltungen mit einem Ort, Daten und Künstlern erstellen. Wir erfassen niemals Ihren Live-Standort.';
	@override String get privacy_use_of_data_title => '3. Verwendung der Daten';
	@override String get privacy_use_of_data_body => 'Ihre Daten werden nur verwendet, um die Funktionen der App bereitzustellen. Wir verkaufen oder teilen Ihre Daten nicht mit Dritten.';
	@override String get privacy_user_rights_title => '4. Nutzerrechte';
	@override String get privacy_user_rights_body => 'Gemäß der DSGVO haben Sie die folgenden Rechte:';
	@override String get privacy_user_rights_list1 => 'Zugriff auf Ihre Daten';
	@override String get privacy_user_rights_list2 => 'Ihre Daten herunterladen (Veranstaltungen, Notizen, Bewertungen)';
	@override String get privacy_user_rights_list3 => 'Löschen Ihrer Daten oder Ihres Kontos';
	@override String get privacy_user_rights_list4 => 'Ihre Informationen korrigieren oder ändern';
	@override String get privacy_data_retention_title => '5. Datenspeicherung';
	@override String get privacy_data_retention_body => 'Ihre Daten werden so lange gespeichert, wie Ihr Konto aktiv ist. Sie können Ihr Konto jederzeit löschen.';
	@override String get privacy_contact_title => '6. Contact';
	@override String get privacy_contact_body => 'Bei Fragen zu Ihren personenbezogenen Daten kontaktieren Sie uns bitte unter: evnt.trackr@gmail.com';
}

// Path: profile
class _TranslationsProfileDe extends TranslationsProfileEn {
	_TranslationsProfileDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get profile => 'Profil';
	@override String get memberSince => 'Mitglied seit';
	@override String get totalEvents => 'Events';
	@override String get totalArtists => 'Künstler';
	@override String get averageRating => 'Average';
	@override String get viewMyStats => 'Meine Statistiken ansehen';
	@override String get achievements => 'Erfolge';
	@override String get lastEvent => 'Letztes Event';
	@override String get nextEvent => 'Nächstes Event';
}

// Path: settings
class _TranslationsSettingsDe extends TranslationsSettingsEn {
	_TranslationsSettingsDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get settings => 'Einstellungen';
	@override String get preferences => 'Voreinstellungen';
	@override String get language => 'Sprache';
	@override String get dateFormat => 'Datumsformat';
	@override String get displayMode => 'Anzeigemodus';
	@override String get light => 'Hell';
	@override String get dark => 'Dunkel';
	@override String get system => 'System';
	@override String get account => 'Konto';
	@override String get changePassword => 'Passwort ändern';
	@override String get resetAccount => 'Konto zurücksetzen';
	@override String get resetAccountWarning => 'Das Zurücksetzen Ihres Kontos löscht alle Ihre Veranstaltungen, Bewertungen und Erfolge. Diese Aktion ist irreversibel.';
	@override String get deleteAccount => 'Konto löschen';
	@override String get deleteAccountWarning => 'Das Löschen Ihres Kontos löscht dauerhaft alle Ihre Informationen und Sie werden abgemeldet. Diese Aktion ist irreversibel.';
	@override String get newPassword => 'Neeus Passwort';
	@override String get confirmNewPassword => 'Neues Passwort bestätigen';
	@override String get passwordChangedSuccessfully => 'Passwort erfolgreich geändert';
	@override String get logout => 'Abmelden';
	@override String get profilsettings => 'Profileinstellungen';
	@override String get editprofile => 'Profil bearbeiten';
	@override String get profileUpdated => 'Profil aktualisiert';
	@override String get app => 'App';
	@override String get notif1WeekTitle => 'Erinnerung: 1 Woche vorher';
	@override String get notif1WeekDesc => 'Werde 7 Tage vor dem Event benachrichtigt';
	@override String get notif1DayTitle => 'Erinnerung: 24 Stunden vorher';
	@override String get notif1DayDesc => 'Werde am Tag vor dem Event benachrichtigt';
	@override String get debugNotifTitle => 'Debug: Benachrichtigungen anzeigen';
	@override String get debugNoNotifs => 'Keine geplanten Benachrichtigungen';
	@override String get debugPending => 'Geplante Benachrichtigungen';
}

// Path: stats
class _TranslationsStatsDe extends TranslationsStatsEn {
	_TranslationsStatsDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get myStats => 'Meine Statistiken';
	@override String get totalPerformances => 'Shows';
	@override String get mostSeenArtists => 'Meistgesehene Künstler';
	@override String get bestPerformances => 'Beste Auftritte';
	@override String get festivals => 'Festivals';
	@override String get concerts => 'Konzerte';
	@override String get eventDistribution => 'Event-Verteilung';
	@override String stats_before({required Object minYearStr}) => 'Vor ${minYearStr}';
	@override String get stats_email_subject => '[Statistiken]';
	@override String get didntFindWhatYouWereLookingFor => 'Haben Sie nicht gefunden, was Sie gesucht haben?';
	@override String get tellUs => 'Sagen Sie es uns';
	@override String get expenses => 'Ausgaben';
}

// Path: update
class _TranslationsUpdateDe extends TranslationsUpdateEn {
	_TranslationsUpdateDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get updateAvailable => 'Update verfügbar';
	@override String updateVersionReady({required Object newVersion}) => 'Eine neue version (${newVersion}) ist da!';
	@override String get updateDescription => 'Aktualisiere die App, um die neuesten Funktionen und Sicherheitsfixes zu nutzen.';
	@override String get updateNow => 'Jetzt aktualisieren';
	@override String get updateLater => 'Später';
	@override String get appUpToDate => 'App ist auf dem neuesten Stand';
	@override String get checkUpdate => 'Auf Updates prüfen';
}

/// The flat map containing all translations for locale <de>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsDe {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'about.about' => 'Über',
			'about.createdBy' => 'Erstellt von',
			'about.version' => 'Version',
			'about.versionHistory' => 'Versionsverlauf',
			'about.about_intro1' => 'Als Konzertliebhaber habe ich EvntTrackr ursprünglich für meinen eigenen Bedarf entwickelt. Schluss mit der mühsamen Verwaltung von Tabellenkalkulationen, nur noch eine einfache und zentrale Erfahrung.',
			'about.about_intro2' => 'Überzeugt davon, dass die App auch für andere Enthusiasten nützlich sein könnte, habe ich beschlossen, sie mit Ihnen zu teilen.',
			'about.about_support_title' => 'Unterstützen Sie die Entwicklung',
			'about.about_feedback_text' => 'Ihr Feedback ist wertvoll! Zögern Sie nicht, mir Ihre Gedanken mitzuteilen:',
			'about.about_email_tooltip' => 'E-Mail senden',
			'about.about_instagram_tooltip' => 'Auf Instagram folgen',
			'about.about_donation_text' => 'Eine kleine Geste für ein großes Projekt. Wenn Sie möchten, können Sie mich mit einem Kaffee unterstützen! ☕',
			'about.about_kofi_button' => 'Buy me a coffee',
			'about.about_paypal_button' => 'Spenden',
			'about.about_see_whatsnew' => 'Was ist neu?',
			'about.rate_us' => 'App bewerten',
			'achievements.achievements_firstStep' => 'Erster Schritt',
			'achievements.achievements_firstStepDescription' => 'Protokollieren Sie Ihre erste Veranstaltung.',
			'achievements.achievements_rookieCollector' => 'Anfänger-Sammler',
			'achievements.achievements_rookieCollectorDescription' => 'Nimm einen Künstler auf',
			'achievements.achievements_musicCritic' => 'Musikkritiker',
			'achievements.achievements_musicCriticDescription' => 'Kommt bald',
			'achievements.achievements_curious' => 'Neugierig',
			'achievements.achievements_curiousDescription' => 'Besuche deine Statistikseite',
			'achievements.achievements_regular' => 'Stammgast',
			'achievements.achievements_regularDescription' => '10 Veranstaltungen protokollieren.',
			'achievements.achievements_pillar' => 'Säule',
			'achievements.achievements_pillarDescription' => '25 Veranstaltungen protokollieren.',
			'achievements.achievements_headliner' => 'Headliner',
			'achievements.achievements_headlinerDescription' => '50 Veranstaltungen protokollieren.',
			'achievements.achievements_musicPokedex' => 'Musik-Pokédex',
			'achievements.achievements_musicPokedexDescription' => 'Besuchen Sie Veranstaltungen mit 50 verschiedenen Künstlern.',
			'achievements.achievements_trueFan' => 'Wahrer Fan',
			'achievements.achievements_trueFanDescription' => 'Sehen Sie denselben Künstler bei 5 verschiedenen Veranstaltungen.',
			'achievements.achievements_superFan' => 'Super-Fan',
			'achievements.achievements_superFanDescription' => 'Sehen Sie denselben Künstler bei 10 verschiedenen Veranstaltungen.',
			'achievements.achievements_dieHardFan' => 'Hardcore-Fan',
			'achievements.achievements_dieHardFanDescription' => 'Sehen Sie denselben Künstler bei 15 verschiedenen Veranstaltungen.',
			'achievements.achievements_loyal' => 'Loyal',
			'achievements.achievements_loyalDescription' => 'Kommt bald',
			'achievements.achievements_marathoner' => 'Marathonläufer',
			'achievements.achievements_marathonerDescription' => 'Kommt bald',
			'achievements.achievements_eclectic' => 'Eklektisch',
			'achievements.achievements_eclecticDescription' => 'Besuchen Sie ein Konzert und ein Festival.',
			'achievements.achievements_discoverer' => 'Entdecker',
			'achievements.achievements_discovererDescription' => 'Kommt bald',
			'achievements.achievements_globetrotter' => 'Weltenbummler',
			'achievements.achievements_globetrotterDescription' => 'Besuchen Sie Veranstaltungen an mindestens 5 verschiedenen Orten.',
			'achievements.achievements_archaeologist' => 'Archäologe',
			'achievements.achievements_archaeologistDescription' => 'Protokollieren Sie eine Veranstaltung von vor mehr als 5 Jahren.',
			'achievements.achievements_nightOwl' => 'Nachteule',
			'achievements.achievements_nightOwlDescription' => 'Registriere eine Veranstaltung zwischen 0 und 6 Uhr',
			'achievements.achievements_oops' => 'Hoppla',
			'achievements.achievements_oopsDescription' => 'Löscht ein Ereignis.',
			'achievements.achievements_summerFest' => 'Sommerfest',
			'achievements.achievements_summerFestDescription' => 'Kommt bald',
			'achievements.achievements_liveLegend' => 'Live-Legende',
			'achievements.achievements_liveLegendDescription' => '100 Veranstaltungen protokollieren.',
			'achievements.achievements_pioneer' => 'Pionier',
			'achievements.achievements_pioneerDescription' => 'Nehmen Sie an der EvntTrackr-Beta teil.',
			'achievements.achievements_venueRegular' => 'Der Stammgast',
			'achievements.achievements_venueRegularDescription' => 'Besuche 5 Veranstaltungen am selben Ort.',
			'achievements.achievements_venuePillar' => 'Säule des Hauses',
			'achievements.achievements_venuePillarDescription' => 'Besuche 10 Veranstaltungen am selben Ort',
			'achievements.achievements_venueLegend' => 'Legende des Hauses',
			'achievements.achievements_venueLegendDescription' => 'Besuche 15 Veranstaltungen am selben Ort',
			'achievements.rarity_common' => 'Gewöhnlich',
			'achievements.rarity_uncommon' => 'Ungewöhnlich',
			'achievements.rarity_rare' => 'Selten',
			'achievements.rarity_epic' => 'Episch',
			'achievements.rarity_legendary' => 'Legendär',
			'artists.artist' => 'Künstler',
			'artists.artists' => 'Künstler',
			'artists.addArtist' => 'Künstler hinzufügen',
			'artists.viewArtist' => 'Künstler ansehen',
			'artists.rateArtist' => 'Künstler bewerten',
			'artists.performanceRating' => 'Performance',
			'artists.setlistRatingLabel' => 'Setlist',
			'artists.soundQualityRating' => 'Tonqualität',
			'artists.globalReview' => 'Globale Bewertung',
			'artists.noArtistsForEvent' => 'Keine Künstler für dieses Ereignis.',
			'artists.headliner' => 'Headliner',
			'artists.ratingSaved' => 'Bewertung erfolgreich gespeichert',
			'artists.artistSortOrderHeadliner' => 'Headliner',
			'artists.artistSortOrderAZ' => 'A-Z',
			'artists.artistSortOrderZA' => 'Z-A',
			'auth.signIn' => 'Anmelden',
			'auth.signUp' => 'Registrieren',
			'auth.dontHaveAccount' => 'Ich habe kein Konto',
			'auth.alreadyHaveAccount' => 'Ich habe bereits ein Konto',
			'auth.forgotPassword' => 'Passwort vergessen?',
			'auth.pleaseEnterYourEmail' => 'Gib deine E-Mail-Adresse ein',
			'auth.passwordResetLinkSent' => 'Ein Link zum Zurücksetzen wurde dir per E-Mail gesendet',
			'auth.email' => 'E-Mail',
			'auth.password' => 'Passwort',
			'auth.username' => 'Benutzername',
			'auth.confirmPassword' => 'Passwort bestätigen',
			'auth.welcome' => 'Willkommen bei EvntTrackr 2.3.0!',
			'auth.welcomedescription' => 'Vielen Dank, dass Sie EvntTrackr nutzen! Ich bin mit ganzem Herzen dabei, eine App zu entwickeln, die Ihnen genauso gut gefällt wie mir. Die App befindet sich noch in der Testphase: Ihr Feedback ist für die Verbesserung der App unerlässlich! Zögern Sie nicht, mir Ihr Feedback über die Seite „Über uns” mitzuteilen. Viel Spaß beim Entdecken!',
			'auth.whatsnew' => 'Was ist neu?',
			'auth.moretocome' => 'Mehr zu kommen!',
			'auth.alwaysimproving' => 'EvntTrackr wird ständig verbessert und bietet neue Möglichkeiten, deine Events zu genießen. Zögere nicht, mir dein Feedback über die „Über“-Seite mitzuteilen 💪',
			'auth.letsgo' => 'Los geht\'s!',
			'auth.new1' => 'Online-Event-Suche',
			'auth.new1description' => 'Finde deine Events noch einfacher mit unserer neuen Online-Suche, die externe Datenbanken integriert!',
			'auth.new2' => 'Verpasse nichts mehr',
			'auth.new2description' => 'Aktiviere Event-Erinnerungen mit neuen lokalen Benachrichtigungen, damit du immer pünktlich bist.',
			'auth.new3' => 'Ein stilvolles Profil',
			'auth.new3description' => 'Entdecke eine verbesserte Benutzeroberfläche für deine Profil-, Statistik- und Erfolgsseiten. Schöner und übersichtlicher!',
			'auth.acceptPrivacyPolicy' => 'Ich habe die Datenschutzbestimmungen gelesen und akzeptiere sie',
			'auth.confirmationEmailSent' => 'Bestätigungs-E-Mail gesendet',
			'common.cancel' => 'Abbrechen',
			'common.send' => 'Senden',
			'common.close' => 'Schließen',
			'common.reset' => 'Zurücksetzen',
			'common.create' => 'Erstellen',
			'common.update' => 'Aktualisieren',
			'common.save' => 'Speichern',
			'common.delete' => 'Löschen',
			'common.next' => 'Weiter',
			'common.add' => 'Hinzufügen',
			'common.search' => 'Meine Events filtern...',
			'common.today' => 'Heute',
			'common.tomorrow' => 'Morgen',
			'common.inDays' => ({required Object n}) => 'In ${n} Tagen',
			'common.dateRange' => ({required Object startDate, required Object endDate}) => 'Vom ${startDate} bis ${endDate}',
			'common.pageOutOfTotal' => ({required Object currentPage, required Object totalPages}) => 'Seite ${currentPage} von ${totalPages}',
			'common.noDataAvailable' => 'Keine Daten verfügbar',
			'common.seeAll' => 'Alle anzeigen',
			'common.total' => 'Gesamt',
			'common.rank' => '#',
			'common.seen' => 'Gesehen',
			'common.thisYear' => 'Dieses Jahr',
			'errors.invalidPrice' => 'Bitte geben Sie einen gültigen Preis ein.',
			'errors.pleaseEnterAUsername' => 'Bitte geben Sie einen Benutzernamen ein',
			'errors.pleaseEnterAPassword' => 'Bitte geben Sie ein Passwort ein',
			'errors.pleaseConfirmYourPassword' => 'Bitte bestätigen Sie Ihr Passwort',
			'errors.loginerror' => 'Fehler beim Anmelden versuchen.',
			'errors.eventCreateError' => 'Fehler beim Erstellen der Veranstaltung',
			'errors.eventUpdateError' => 'Fehler beim Aktualisieren der Veranstaltung',
			'errors.artistAddError' => 'Fehler beim Hinzufügen des Künstlers',
			'errors.locationAddError' => 'Fehler beim Hinzufügen des Ortes',
			'errors.errorDeletingEvent' => 'Fehler beim Löschen des Ereignisses',
			'errors.error' => 'Fehler',
			'errors.errorDetails' => 'Fehler',
			'errors.errorUpdatingHeadlinerStatus' => 'Fehler beim Aktualisieren des Headliner-Status.',
			'errors.pleaseAcceptPrivacyPolicy' => 'Bitte akzeptieren Sie die Datenschutzbestimmungen, um fortzufahren',
			'errors.passwordsDoNotMatch' => 'Die Passwörter stimmen nicht überein',
			'errors.passwordTooShort' => 'Das Passwort muss mindestens 6 Zeichen lang sein',
			'errors.passwordComplexity' => 'Das Passwort muss mindestens eine kleine, eine große und eine Zahl enthalten',
			'errors.pleaseEnterNewPassword' => 'Bitte geben Sie ein neues Passwort ein',
			'errors.nameRequired' => 'Name erforderlich',
			'errors.locationRequired' => 'Bitte wählen Sie einen Ort aus',
			'errors.dateRequired' => 'Datum erforderlich',
			'errors.requiredField' => 'Erforderlich',
			'errors.invalidNumber' => 'Ungültige Nummer',
			'events.events' => 'Events',
			'events.eventname' => 'Veranstaltungsname',
			'events.location' => 'Ort',
			'events.start' => 'Start',
			'events.end' => 'Ende',
			'events.datetime' => 'Datum und Uhrzeit',
			'events.gotmyticket' => 'Ich habe mein Ticket',
			'events.price' => 'Preis',
			'events.eventtype' => 'Veranstaltungstyp',
			'events.festival' => 'Festival',
			'events.concert' => 'Concert',
			'events.createevent' => 'Veranstaltung erstellen',
			'events.editEvent' => 'Veranstaltung bearbeiten',
			'events.editevent' => 'Event bearbeiten',
			'events.eventCreatedSuccess' => 'Veranstaltung erfolgreich erstellt!',
			'events.eventUpdatedSuccess' => 'Veranstaltung erfolgreich aktualisiert!',
			'events.eventDeletedSuccessfully' => 'Ereignis erfolgreich gelöscht.',
			'events.noEventDetailsFound' => 'Keine Details für dieses Ereignis gefunden.',
			'events.deleteEvent' => 'Ereignis löschen',
			'events.confirmDeletion' => 'Löschung bestätigen',
			'events.confirmDeleteEventMessage' => 'Sind Sie sicher, dass Sie dieses Ereignis löschen möchten? Diese Aktion ist irreversibel.',
			'events.event_ongoing' => 'Laufend',
			'events.upcoming' => 'Anstehend',
			'events.past' => 'Vergangen',
			'events.bookmarked' => 'Gespeichert',
			'events.noupcoming' => 'Keine anstehenden Veranstaltungen.',
			'events.nopast' => 'Keine vergangenen Veranstaltungen.',
			'events.nobookmarked' => 'Keine gespeicherten Veranstaltungen.',
			'events.addToUpcoming' => 'Als gekauft markieren?',
			'events.addToUpcomingInfo' => 'Dadurch wird die Veranstaltung auf die Registerkarte "Anstehend" verschoben.',
			'events.eventAddedToUpcoming' => 'Veranstaltung zur Liste "Anstehend" hinzugefügt',
			'events.priceWithCurrency' => 'Preis (€)',
			'events.ticketPriceOptional' => 'Ticketpreis (optional)',
			'events.searchPlaceholder' => 'Nach Event, Künstler suchen...',
			'events.filterAroundMe' => 'In meiner Nähe',
			'events.filterGenre' => 'Genre',
			'events.filterDate' => 'Nach Datum filtern',
			'events.unknownLocation' => 'Unbekannter Ort',
			'events.artistsIncluded' => 'Künstler enthalten',
			'events.artistIncluded' => 'Künstler enthalten',
			'events.noEventDetailsFoundDesc' => 'Keine Sorge, Sie können es manuell erstellen! (Veranstaltungsort und Künstler werden vorgeschlagen)',
			'events.createManually' => 'Manuell erstellen',
			'events.searchOnlineTitle' => 'Online-Suche',
			'events.searchBetaDesc' => 'Funktion in Beta: Einige Ereignisse werden möglicherweise nicht gefunden.',
			'notifications.titles.0' => 'Erinnerung!',
			'notifications.titles.1' => 'Bald ist es soweit!',
			'notifications.titles.2' => 'Mach dich bereit!',
			'notifications.titles.3' => 'Bevorstehendes Event!',
			'notifications.withTicket' => ({required Object name, required Object time}) => '${name} findet in ${time} statt. Vergiss dein Ticket nicht!',
			'notifications.withoutTicket' => ({required Object name, required Object time}) => '${name} findet in ${time} statt. Hast du dein Ticket schon?',
			'notifications.details' => ({required Object date, required Object location}) => 'Datum: ${date} • Ort: ${location}',
			'notifications.time1Week' => 'einer Woche',
			'notifications.time24h' => '24 Stunden',
			'notifications.channelName' => 'Event-Erinnerungen',
			'notifications.channelDesc' => 'Benachrichtigungen, die dich an bevorstehende Events erinnern',
			'onboarding.welcomeTitle' => 'Willkommen!',
			'onboarding.welcomeSubtitle' => 'Beginnen wir damit, Ihre Einstellungen für ein optimales Erlebnis festzulegen.',
			'onboarding.languageTitle' => 'Sprache',
			'onboarding.languageSubtitle' => 'Wählen Sie Ihre bevorzugte Sprache',
			'onboarding.themeTitle' => 'Design',
			'onboarding.themeSubtitle' => 'Passen Sie das Erscheinungsbild der App an',
			'onboarding.dateFormatTitle' => 'Datumsformat',
			'onboarding.dateFormatSubtitle' => 'Wie möchten Sie Daten am liebsten lesen?',
			'onboarding.readyTitle' => 'Alles bereit!',
			'onboarding.readySubtitle' => 'Sie müssen sich nur noch anmelden oder registrieren, um loszulegen!',
			'onboarding.next' => 'Weiter',
			'onboarding.start' => 'Starten',
			'onboarding.back' => 'Zurück',
			'onboarding.notificationsTitle' => 'Benachrichtigungen',
			'onboarding.notificationsSubtitle' => 'Verpasse keines deiner Events',
			'privacy.privacyPolicy' => 'Datenschutzbestimmungen',
			'privacy.privacyPolicyTitle' => 'Datenschutzbestimmungen',
			'privacy.privacyPolicyContent' => 'Ihre Privatsphäre ist uns wichtig.',
			'privacy.privacy_intro_title' => '1. Einführung',
			'privacy.privacy_intro_body' => 'EvntTrackr verpflichtet sich, Ihre personenbezogenen Daten in Übereinstimmung mit der Datenschutz-Grundverordnung (DSGVO) zu schützen. Diese Richtlinie erklärt, wie wir Ihre Informationen sammeln, verwenden und schützen.',
			'privacy.privacy_data_collected_title' => '2. Erhobene Daten',
			'privacy.privacy_data_collected_body' => 'Um EvntTrackr zu nutzen, müssen Sie ein Konto mit einer E-Mail-Adresse und einem Passwort erstellen. Innerhalb der App können Sie Veranstaltungen mit einem Ort, Daten und Künstlern erstellen. Wir erfassen niemals Ihren Live-Standort.',
			'privacy.privacy_use_of_data_title' => '3. Verwendung der Daten',
			'privacy.privacy_use_of_data_body' => 'Ihre Daten werden nur verwendet, um die Funktionen der App bereitzustellen. Wir verkaufen oder teilen Ihre Daten nicht mit Dritten.',
			'privacy.privacy_user_rights_title' => '4. Nutzerrechte',
			'privacy.privacy_user_rights_body' => 'Gemäß der DSGVO haben Sie die folgenden Rechte:',
			'privacy.privacy_user_rights_list1' => 'Zugriff auf Ihre Daten',
			'privacy.privacy_user_rights_list2' => 'Ihre Daten herunterladen (Veranstaltungen, Notizen, Bewertungen)',
			'privacy.privacy_user_rights_list3' => 'Löschen Ihrer Daten oder Ihres Kontos',
			'privacy.privacy_user_rights_list4' => 'Ihre Informationen korrigieren oder ändern',
			'privacy.privacy_data_retention_title' => '5. Datenspeicherung',
			'privacy.privacy_data_retention_body' => 'Ihre Daten werden so lange gespeichert, wie Ihr Konto aktiv ist. Sie können Ihr Konto jederzeit löschen.',
			'privacy.privacy_contact_title' => '6. Contact',
			'privacy.privacy_contact_body' => 'Bei Fragen zu Ihren personenbezogenen Daten kontaktieren Sie uns bitte unter: evnt.trackr@gmail.com',
			'profile.profile' => 'Profil',
			'profile.memberSince' => 'Mitglied seit',
			'profile.totalEvents' => 'Events',
			'profile.totalArtists' => 'Künstler',
			'profile.averageRating' => 'Average',
			'profile.viewMyStats' => 'Meine Statistiken ansehen',
			'profile.achievements' => 'Erfolge',
			'profile.lastEvent' => 'Letztes Event',
			'profile.nextEvent' => 'Nächstes Event',
			'settings.settings' => 'Einstellungen',
			'settings.preferences' => 'Voreinstellungen',
			'settings.language' => 'Sprache',
			'settings.dateFormat' => 'Datumsformat',
			'settings.displayMode' => 'Anzeigemodus',
			'settings.light' => 'Hell',
			'settings.dark' => 'Dunkel',
			'settings.system' => 'System',
			'settings.account' => 'Konto',
			'settings.changePassword' => 'Passwort ändern',
			'settings.resetAccount' => 'Konto zurücksetzen',
			'settings.resetAccountWarning' => 'Das Zurücksetzen Ihres Kontos löscht alle Ihre Veranstaltungen, Bewertungen und Erfolge. Diese Aktion ist irreversibel.',
			'settings.deleteAccount' => 'Konto löschen',
			'settings.deleteAccountWarning' => 'Das Löschen Ihres Kontos löscht dauerhaft alle Ihre Informationen und Sie werden abgemeldet. Diese Aktion ist irreversibel.',
			'settings.newPassword' => 'Neeus Passwort',
			'settings.confirmNewPassword' => 'Neues Passwort bestätigen',
			'settings.passwordChangedSuccessfully' => 'Passwort erfolgreich geändert',
			'settings.logout' => 'Abmelden',
			'settings.profilsettings' => 'Profileinstellungen',
			'settings.editprofile' => 'Profil bearbeiten',
			'settings.profileUpdated' => 'Profil aktualisiert',
			'settings.app' => 'App',
			'settings.notif1WeekTitle' => 'Erinnerung: 1 Woche vorher',
			'settings.notif1WeekDesc' => 'Werde 7 Tage vor dem Event benachrichtigt',
			'settings.notif1DayTitle' => 'Erinnerung: 24 Stunden vorher',
			'settings.notif1DayDesc' => 'Werde am Tag vor dem Event benachrichtigt',
			'settings.debugNotifTitle' => 'Debug: Benachrichtigungen anzeigen',
			'settings.debugNoNotifs' => 'Keine geplanten Benachrichtigungen',
			'settings.debugPending' => 'Geplante Benachrichtigungen',
			'stats.myStats' => 'Meine Statistiken',
			'stats.totalPerformances' => 'Shows',
			'stats.mostSeenArtists' => 'Meistgesehene Künstler',
			'stats.bestPerformances' => 'Beste Auftritte',
			'stats.festivals' => 'Festivals',
			'stats.concerts' => 'Konzerte',
			'stats.eventDistribution' => 'Event-Verteilung',
			'stats.stats_before' => ({required Object minYearStr}) => 'Vor ${minYearStr}',
			'stats.stats_email_subject' => '[Statistiken]',
			'stats.didntFindWhatYouWereLookingFor' => 'Haben Sie nicht gefunden, was Sie gesucht haben?',
			'stats.tellUs' => 'Sagen Sie es uns',
			'stats.expenses' => 'Ausgaben',
			'update.updateAvailable' => 'Update verfügbar',
			'update.updateVersionReady' => ({required Object newVersion}) => 'Eine neue version (${newVersion}) ist da!',
			'update.updateDescription' => 'Aktualisiere die App, um die neuesten Funktionen und Sicherheitsfixes zu nutzen.',
			'update.updateNow' => 'Jetzt aktualisieren',
			'update.updateLater' => 'Später',
			'update.appUpToDate' => 'App ist auf dem neuesten Stand',
			'update.checkUpdate' => 'Auf Updates prüfen',
			_ => null,
		};
	}
}
