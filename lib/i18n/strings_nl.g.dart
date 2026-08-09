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
class TranslationsNl extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsNl({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.nl,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <nl>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsNl _root = this; // ignore: unused_field

	@override 
	TranslationsNl $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsNl(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsAboutNl about = _TranslationsAboutNl._(_root);
	@override late final _TranslationsAchievementsNl achievements = _TranslationsAchievementsNl._(_root);
	@override late final _TranslationsArtistsNl artists = _TranslationsArtistsNl._(_root);
	@override late final _TranslationsAuthNl auth = _TranslationsAuthNl._(_root);
	@override late final _TranslationsCommonNl common = _TranslationsCommonNl._(_root);
	@override late final _TranslationsErrorsNl errors = _TranslationsErrorsNl._(_root);
	@override late final _TranslationsEventsNl events = _TranslationsEventsNl._(_root);
	@override late final _TranslationsNotificationsNl notifications = _TranslationsNotificationsNl._(_root);
	@override late final _TranslationsOnboardingNl onboarding = _TranslationsOnboardingNl._(_root);
	@override late final _TranslationsPrivacyNl privacy = _TranslationsPrivacyNl._(_root);
	@override late final _TranslationsProfileNl profile = _TranslationsProfileNl._(_root);
	@override late final _TranslationsSettingsNl settings = _TranslationsSettingsNl._(_root);
	@override late final _TranslationsStatsNl stats = _TranslationsStatsNl._(_root);
	@override late final _TranslationsUpdateNl update = _TranslationsUpdateNl._(_root);
}

// Path: about
class _TranslationsAboutNl extends TranslationsAboutEn {
	_TranslationsAboutNl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get about => 'Over';
	@override String get createdBy => 'Gemaakt door';
	@override String get version => 'Versie';
	@override String get versionHistory => 'Versiegeschiedenis';
	@override String get about_intro1 => 'Als concertliefhebber heb ik EvntTrackr in eerste instantie voor mijn eigen behoeften gemaakt. Geen gedoe meer met het beheren van spreadsheets, maar een eenvoudige et gecentraliseerde ervaring.';
	@override String get about_intro2 => 'Overtuigd dat de app ook nuttig zou kunnen zijn voor andere liefhebbers, heb ich besloten deze met jullie te delen.';
	@override String get about_support_title => 'Ondersteun de ontwikkeling';
	@override String get about_feedback_text => 'Jouw feedback is waardevol! Deel gerust je gedachten met mij:';
	@override String get about_email_tooltip => 'Stuur een e-mail';
	@override String get about_instagram_tooltip => 'Volg op Instagram';
	@override String get about_donation_text => 'Een klein gebaar voor een groot project. Als je wilt, kun je me steunen met een kopje koffie! ☕';
	@override String get about_kofi_button => 'Buy me a coffee';
	@override String get about_paypal_button => 'Doneren';
	@override String get about_see_whatsnew => 'Bekijk wat nieuwe';
	@override String get rate_us => 'App evalueren';
}

// Path: achievements
class _TranslationsAchievementsNl extends TranslationsAchievementsEn {
	_TranslationsAchievementsNl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get achievements_firstStep => 'Eerste stap';
	@override String get achievements_firstStepDescription => 'Log je eerste evenement.';
	@override String get achievements_rookieCollector => 'Beginnende verzamelaar';
	@override String get achievements_rookieCollectorDescription => 'Registreer een artiest';
	@override String get achievements_musicCritic => 'Muziekcriticus';
	@override String get achievements_musicCriticDescription => 'Binnenkort beschikbaar';
	@override String get achievements_curious => 'Nieuwsgierig';
	@override String get achievements_curiousDescription => 'Bezoek je statistiekenpagina';
	@override String get achievements_regular => 'Regelmatig';
	@override String get achievements_regularDescription => 'Log 10 evenementen.';
	@override String get achievements_pillar => 'Pilaar';
	@override String get achievements_pillarDescription => 'Log 25 evenementen.';
	@override String get achievements_headliner => 'Headliner';
	@override String get achievements_headlinerDescription => 'Log 50 evenementen.';
	@override String get achievements_musicPokedex => 'Muziek Pokédex';
	@override String get achievements_musicPokedexDescription => 'Woon evenementen bij met 50 verschillende artiesten.';
	@override String get achievements_trueFan => 'Echte fan';
	@override String get achievements_trueFanDescription => 'Zie dezelfde artiest op 5 verschillende evenementen.';
	@override String get achievements_superFan => 'Superfan';
	@override String get achievements_superFanDescription => 'Zie dezelfde artiest op 10 verschillende evenementen.';
	@override String get achievements_dieHardFan => 'Die-hard fan';
	@override String get achievements_dieHardFanDescription => 'Zie dezelfde artiest op 15 different evenementen.';
	@override String get achievements_loyal => 'Loyaal';
	@override String get achievements_loyalDescription => 'Binnenkort beschikbaar';
	@override String get achievements_marathoner => 'Marathonloper';
	@override String get achievements_marathonerDescription => 'Binnenkort beschikbaar';
	@override String get achievements_eclectic => 'Eclectisch';
	@override String get achievements_eclecticDescription => 'Woon een concert en een festival bij.';
	@override String get achievements_discoverer => 'Ontdekker';
	@override String get achievements_discovererDescription => 'Binnenkort beschikbaar';
	@override String get achievements_globetrotter => 'Wereldreiziger';
	@override String get achievements_globetrotterDescription => 'Woon evenementen bij op minimaal 5 verschillende locaties.';
	@override String get achievements_archaeologist => 'Archeoloog';
	@override String get achievements_archaeologistDescription => 'Log een evenement van meer dan 5 jaar geleden.';
	@override String get achievements_nightOwl => 'Nachtbraker';
	@override String get achievements_nightOwlDescription => 'Registreer een evenement tussen 0u et 6u';
	@override String get achievements_oops => 'Oeps';
	@override String get achievements_oopsDescription => 'Verwijder een evenement';
	@override String get achievements_summerFest => 'Zomerfestival';
	@override String get achievements_summerFestDescription => 'Binnenkort beschikbaar';
	@override String get achievements_liveLegend => 'Live legende';
	@override String get achievements_liveLegendDescription => 'Log 100 evenementen.';
	@override String get achievements_pioneer => 'Pionier';
	@override String get achievements_pioneerDescription => 'Neem deel aan de EvntTrackr-bèta.';
	@override String get achievements_venueRegular => 'De Stamgast';
	@override String get achievements_venueRegularDescription => 'Bezoek 5 evenementen op dezelfde locatie.';
	@override String get achievements_venuePillar => 'Zaalpilaar';
	@override String get achievements_venuePillarDescription => 'Bezoek 10 evenementen op dezelfde locatie';
	@override String get achievements_venueLegend => 'Zaallegende';
	@override String get achievements_venueLegendDescription => 'Bezoek 15 evenementen op dezelfde locatie';
	@override String get rarity_common => 'Gewoon';
	@override String get rarity_uncommon => 'Ongewoon';
	@override String get rarity_rare => 'Zeldzaam';
	@override String get rarity_epic => 'Episch';
	@override String get rarity_legendary => 'Legendair';
}

// Path: artists
class _TranslationsArtistsNl extends TranslationsArtistsEn {
	_TranslationsArtistsNl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get artist => 'Artiest';
	@override String get artists => 'Artiesten';
	@override String get addArtist => 'Artiest toevoegen';
	@override String get viewArtist => 'Bekijk artiest';
	@override String get rateArtist => 'Beoordeel artiest';
	@override String get performanceRating => 'Performance';
	@override String get setlistRatingLabel => 'Setlist';
	@override String get soundQualityRating => 'Geluidskwaliteit';
	@override String get globalReview => 'Globale beoordeling';
	@override String get noArtistsForEvent => 'Geen artiesten voor dit evenement.';
	@override String get headliner => 'Headliner';
	@override String get ratingSaved => 'Beoordeling succesvol opgeslagen';
	@override String get artistSortOrderHeadliner => 'Headliners';
	@override String get artistSortOrderAZ => 'A-Z';
	@override String get artistSortOrderZA => 'Z-A';
}

// Path: auth
class _TranslationsAuthNl extends TranslationsAuthEn {
	_TranslationsAuthNl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get signIn => 'Inloggen';
	@override String get signUp => 'Aanmelden';
	@override String get dontHaveAccount => 'Ik heb geen account';
	@override String get alreadyHaveAccount => 'Ik heb al een account';
	@override String get forgotPassword => 'Wachtwoord vergeten?';
	@override String get pleaseEnterYourEmail => 'Vul je e-mailadres in';
	@override String get passwordResetLinkSent => 'Een link voor wachtwoordherstel is naar je gemaild';
	@override String get email => 'E-mail';
	@override String get password => 'Wachtwoord';
	@override String get username => 'Gebruikersnaam';
	@override String get confirmPassword => 'Bevestig wachtwoord';
	@override String get welcome => 'Welkom bij EvntTrackr 2.3.0!';
	@override String get welcomedescription => 'Bedankt voor het gebruik van EvntTrackr! Ik zet me met hart et ziel in om een app te ontwikkelen die bij u past et waar ich zelf ook enthousiast over ben. De app bevindt zich nog in de testfase: uw feedback is essentieel om hem te verbeteren! Aarzel niet om mij uw mening te geven via de pagina ‘Over ons’. Veel plezier met ontdekken!';
	@override String get whatsnew => 'Wat is nieuw?';
	@override String get moretocome => 'Meer om te komen!';
	@override String get alwaysimproving => 'EvntTrackr blijft verbeteren et brengt nieuwe manieren om van je evenementen te genieten. Aarzel niet om je feedback te delen via de \'Over\'-pagina 💪';
	@override String get letsgo => 'Laten we gaan!';
	@override String get new1 => 'Online evenementen zoeken';
	@override String get new1description => 'Vind je evenementen nog gemakkelijker met onze nieuwe online zoekopdracht die externe databases integreert!';
	@override String get new2 => 'Mis nooit meer iets';
	@override String get new2description => 'Schakel evenementherinneringen in met nieuwe lokale meldingen, zodat u altijd op tijd bent.';
	@override String get new3 => 'Een stijlvol profiel';
	@override String get new3description => 'Ontdek een verbeterde gebruikersinterface voor je profiel-, statistieken- en prestatiepagina\'s. Mooier en duidelijker!';
	@override String get acceptPrivacyPolicy => 'Ik heb het privacybeleid gelezen en ga akkoord';
	@override String get confirmationEmailSent => 'Bevestigingsmail verzonden';
}

// Path: common
class _TranslationsCommonNl extends TranslationsCommonEn {
	_TranslationsCommonNl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Annuleren';
	@override String get send => 'Verzenden';
	@override String get close => 'Sluiten';
	@override String get reset => 'Wissen';
	@override String get create => 'Aanmaken';
	@override String get update => 'Bijwerken';
	@override String get save => 'Opslaan';
	@override String get delete => 'Verwijderen';
	@override String get next => 'Volgende';
	@override String get add => 'Toevoegen';
	@override String get search => 'Mijn evenementen filteren...';
	@override String get today => 'Vandaag';
	@override String get tomorrow => 'Demain';
	@override String inDays({required Object n}) => 'Over ${n} dagen';
	@override String dateRange({required Object startDate, required Object endDate}) => 'Van ${startDate} tot ${endDate}';
	@override String pageOutOfTotal({required Object currentPage, required Object totalPages}) => 'Pagina ${currentPage} van ${totalPages}';
	@override String get noDataAvailable => 'Geen gegevens beschikbaar';
	@override String get seeAll => 'Alles zien';
	@override String get total => 'Totaal';
	@override String get rank => '#';
	@override String get seen => 'Gezien';
	@override String get thisYear => 'Dit jaar';
}

// Path: errors
class _TranslationsErrorsNl extends TranslationsErrorsEn {
	_TranslationsErrorsNl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get invalidPrice => 'Voer een geldige prijs in.';
	@override String get pleaseEnterAUsername => 'Voer een gebruikersnaam in';
	@override String get pleaseEnterAPassword => 'Voer een wachtwoord in';
	@override String get pleaseConfirmYourPassword => 'Bevestig uw wachtwoord';
	@override String get loginerror => 'Fout bij het inloggen.';
	@override String get eventCreateError => 'Fout bij het aanmaken van het evenement';
	@override String get eventUpdateError => 'Fout bij het bijwerken van het evenement';
	@override String get artistAddError => 'Fout bij het toevoegen van artiest';
	@override String get locationAddError => 'Fout bij het toevoegen van de locatie';
	@override String get errorDeletingEvent => 'Fout bij het verwijderen van evenement';
	@override String get error => 'Fout';
	@override String get errorDetails => 'Fout';
	@override String get errorUpdatingHeadlinerStatus => 'Fout bij het bijwerken van de headlinerstatus.';
	@override String get pleaseAcceptPrivacyPolicy => 'Accepteer het privacybeleid om door te gaan';
	@override String get passwordsDoNotMatch => 'Wachtwoorden komen niet overeen';
	@override String get passwordTooShort => 'Wachtwoord moet minimaal 6 tekens bevatten';
	@override String get passwordComplexity => 'Wachtwoord moet minimaal een kleine, een grote et un cijfer bevatten';
	@override String get pleaseEnterNewPassword => 'Voer een nieuw wachtwoord in';
	@override String get nameRequired => 'Naam verplicht';
	@override String get locationRequired => 'Selecteer een locatie';
	@override String get dateRequired => 'Datum vereist';
	@override String get requiredField => 'Verplicht';
	@override String get invalidNumber => 'Ongeldig nummer';
}

// Path: events
class _TranslationsEventsNl extends TranslationsEventsEn {
	_TranslationsEventsNl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get events => 'Events';
	@override String get eventname => 'Evenementennaam';
	@override String get location => 'Locatie';
	@override String get start => 'Begin';
	@override String get end => 'Einde';
	@override String get datetime => 'Datum en tijd';
	@override String get gotmyticket => 'Ik heb mijn ticket';
	@override String get price => 'Prijs';
	@override String get eventtype => 'Evenemententype';
	@override String get festival => 'Festival';
	@override String get concert => 'Concert';
	@override String get createevent => 'Evenement aanmaken';
	@override String get editEvent => 'Evenement bewerken';
	@override String get editevent => 'Evenement bewerken';
	@override String get eventCreatedSuccess => 'Evenement succesvol aangemaakt!';
	@override String get eventUpdatedSuccess => 'Evenement succesvol bijgewerkt!';
	@override String get eventDeletedSuccessfully => 'Evenement succesvol verwijderd.';
	@override String get noEventDetailsFound => 'Geen details gevonden voor dit evenement.';
	@override String get deleteEvent => 'Evenement verwijderen';
	@override String get confirmDeletion => 'Verwijdering bevestigen';
	@override String get confirmDeleteEventMessage => 'Weet u zeker dat u dit evenement wilt verwijderen? Deze action is onomkeerbaar.';
	@override String get event_ongoing => 'Bezig';
	@override String get upcoming => 'Aankomend';
	@override String get past => 'Verleden';
	@override String get bookmarked => 'Opgeslagen';
	@override String get noupcoming => 'Geen aanstaande evenementen.';
	@override String get nopast => 'Geen evenementen in het verleden.';
	@override String get nobookmarked => 'Geen opgeslagen evenementen.';
	@override String get addToUpcoming => 'Markeren als gekocht?';
	@override String get addToUpcomingInfo => 'Hiermee wordt het evenement verplaatst naar het tabblad \'Aankomend\'.';
	@override String get eventAddedToUpcoming => 'Evenement toegevoegd aan de lijst "Aankomend"';
	@override String get priceWithCurrency => 'Prijs (€)';
	@override String get ticketPriceOptional => 'Ticketprijs (optioneel)';
	@override String get searchPlaceholder => 'Zoek naar een evenement, een artiest...';
	@override String get filterAroundMe => 'Om me heen';
	@override String get filterGenre => 'Genre';
	@override String get filterDate => 'Filteren op datum';
	@override String get unknownLocation => 'Onbekende locatie';
	@override String get artistsIncluded => 'artiesten inbegrepen';
	@override String get artistIncluded => 'artiest inbegrepen';
	@override String get noEventDetailsFoundDesc => 'Geen zorgen, u kunt het handmatig aanmaken! (Locatie en artiesten worden voorgesteld)';
	@override String get createManually => 'Handmatig aanmaken';
	@override String get searchOnlineTitle => 'Online zoeken';
	@override String get searchBetaDesc => 'Functie in Beta: het is mogelijk dat sommige evenementen niet worden gevonden.';
}

// Path: notifications
class _TranslationsNotificationsNl extends TranslationsNotificationsEn {
	_TranslationsNotificationsNl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override List<String> get titles => [
		'Herinnering!',
		'Het is bijna zover!',
		'Maak je klaar!',
		'Aankomend evenement!',
	];
	@override String withTicket({required Object name, required Object time}) => '${name} vindt over ${time} plaats. Vergeet je ticket niet!';
	@override String withoutTicket({required Object name, required Object time}) => '${name} vindt over ${time} plaats. Heb je je ticket al?';
	@override String details({required Object date, required Object location}) => 'Datum: ${date} • Locatie: ${location}';
	@override String get time1Week => 'een week';
	@override String get time24h => '24 uur';
	@override String get channelName => 'Evenement Herinneringen';
	@override String get channelDesc => 'Meldingen om je te herinneren aan je aankomende evenementen';
}

// Path: onboarding
class _TranslationsOnboardingNl extends TranslationsOnboardingEn {
	_TranslationsOnboardingNl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get welcomeTitle => 'Welkom!';
	@override String get welcomeSubtitle => 'Laten we beginnen met het instellen van uw voorkeuren voor de beste ervaring.';
	@override String get languageTitle => 'Taal';
	@override String get languageSubtitle => 'Kies uw voorkeurstaal';
	@override String get themeTitle => 'Thema';
	@override String get themeSubtitle => 'Pas het uiterlijk van de app aan';
	@override String get dateFormatTitle => 'Datumnotatie';
	@override String get dateFormatSubtitle => 'Hoe leest u data het liefst?';
	@override String get readyTitle => 'Alles klaar!';
	@override String get readySubtitle => 'U hoeft alleen nog in te loggen of aan te melden om te beginnen!';
	@override String get next => 'Volgende';
	@override String get start => 'Starten';
	@override String get back => 'Vorige';
	@override String get notificationsTitle => 'Meldingen';
	@override String get notificationsSubtitle => 'Mis geen van je evenementen';
}

// Path: privacy
class _TranslationsPrivacyNl extends TranslationsPrivacyEn {
	_TranslationsPrivacyNl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get privacyPolicy => 'Privacybeleid';
	@override String get privacyPolicyTitle => 'Privacybeleid';
	@override String get privacyPolicyContent => 'Uw privacy is belangrijk voor ons.';
	@override String get privacy_intro_title => '1. Inleiding';
	@override String get privacy_intro_body => 'EvntTrackr zet zich in voor de bescherming van uw persoonlijke gegevens in overeenstemming met de Algemene Verordening Gegevensbescherming (AVG/GDPR). Dit beleid legt uit hoe we uw informatie verzamelen, gebruiken en beschermen.';
	@override String get privacy_data_collected_title => '2. Verzamelde gegevens';
	@override String get privacy_data_collected_body => 'Om EvntTrackr te gebruiken, moet u een account aanmaken met een e-mailadres et wachtwoord. Binnen de app kunt u evenementen maken met een locatie, datums en artiesten. We verzamelen nooit uw live locatie.';
	@override String get privacy_use_of_data_title => '3. Gebruik van gegevens';
	@override String get privacy_use_of_data_body => 'Uw gegevens worden alleen gebruikt om de functies van de app te bieden. We verkopen of teilen uw gegevens niet met derden.';
	@override String get privacy_user_rights_title => '4. Gebruikersrechten';
	@override String get privacy_user_rights_body => 'Onder de AVG heeft u de volgende rechten:';
	@override String get privacy_user_rights_list1 => 'Toegang tot uw gegevens';
	@override String get privacy_user_rights_list2 => 'Download uw gegevens (evenementen, notities, beoordelingen)';
	@override String get privacy_user_rights_list3 => 'Verwijder uw gegevens of account';
	@override String get privacy_user_rights_list4 => 'Corrigeer of wijzig uw informatie';
	@override String get privacy_data_retention_title => '5. Gegevensbewaring';
	@override String get privacy_data_retention_body => 'Uw gegevens worden bewaard zolang uw account actief is. U kunt uw account op elk gewenst moment verwijderen.';
	@override String get privacy_contact_title => '6. Contact';
	@override String get privacy_contact_body => 'Voor vragen over uw persoonlijke gegevens kunt u contact met ons opnemen via: evnt.trackr@gmail.com';
}

// Path: profile
class _TranslationsProfileNl extends TranslationsProfileEn {
	_TranslationsProfileNl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get profile => 'Profil';
	@override String get memberSince => 'Lid sinds';
	@override String get totalEvents => 'Evenementen';
	@override String get totalArtists => 'Artiesten';
	@override String get averageRating => 'Average';
	@override String get viewMyStats => 'Bekijk mijn statistieken';
	@override String get achievements => 'Prestaties';
	@override String get lastEvent => 'Laatste evenement';
	@override String get nextEvent => 'Volgend evenement';
}

// Path: settings
class _TranslationsSettingsNl extends TranslationsSettingsEn {
	_TranslationsSettingsNl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get settings => 'Instellingen';
	@override String get preferences => 'Voorkeuren';
	@override String get language => 'Taal';
	@override String get dateFormat => 'Datumnotatie';
	@override String get displayMode => 'Weergavemodus';
	@override String get light => 'Licht';
	@override String get dark => 'Donker';
	@override String get system => 'Systeem';
	@override String get account => 'Account';
	@override String get changePassword => 'Wachtwoord wijzigen';
	@override String get resetAccount => 'Account resetten';
	@override String get resetAccountWarning => 'Het resetten van je account verwijdert al je evenementen, beoordelingen en prestaties. Deze actie is onomkeerbaar.';
	@override String get deleteAccount => 'Account verwijderen';
	@override String get deleteAccountWarning => 'Het verwijderen van je account wist permanent al je informatie en je wordt uitgelogd. Deze actie is onomkeerbaar.';
	@override String get newPassword => 'Nieuw wachtwoord';
	@override String get confirmNewPassword => 'Bevestig nieuw wachtwoord';
	@override String get passwordChangedSuccessfully => 'Wachtwoord succesvol gewijzigd';
	@override String get logout => 'Uitloggen';
	@override String get profilsettings => 'Profielinstellingen';
	@override String get editprofile => 'Profiel wijzigen';
	@override String get profileUpdated => 'Profiel bijgewerkt';
	@override String get app => 'App';
	@override String get notif1WeekTitle => 'Herinnering: 1 week vooraf';
	@override String get notif1WeekDesc => 'Krijg 7 dagen voor het evenement een melding';
	@override String get notif1DayTitle => 'Herinnering: 24 uur vooraf';
	@override String get notif1DayDesc => 'Krijg de dag voor het evenement een melding';
	@override String get debugNotifTitle => 'Debug: Bekijk meldingen';
	@override String get debugNoNotifs => 'Geen geplande meldingen';
	@override String get debugPending => 'Geplande meldingen';
}

// Path: stats
class _TranslationsStatsNl extends TranslationsStatsEn {
	_TranslationsStatsNl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get myStats => 'Mijn Statistieken';
	@override String get totalPerformances => 'Shows';
	@override String get mostSeenArtists => 'Meest geziene artiesten';
	@override String get bestPerformances => 'Beste optredens';
	@override String get festivals => 'Festivals';
	@override String get concerts => 'Concerten';
	@override String get eventDistribution => 'Verdeling van evenementen';
	@override String stats_before({required Object minYearStr}) => 'Vóór ${minYearStr}';
	@override String get stats_email_subject => '[Statistieken]';
	@override String get didntFindWhatYouWereLookingFor => 'Niet gevonden wat je zocht?';
	@override String get tellUs => 'Vertel het ons';
	@override String get expenses => 'Uitgaven';
}

// Path: update
class _TranslationsUpdateNl extends TranslationsUpdateEn {
	_TranslationsUpdateNl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get updateAvailable => 'Update beschikbaar';
	@override String updateVersionReady({required Object newVersion}) => 'Een nieuwe versie (${newVersion}) is beschikbaar!';
	@override String get updateDescription => 'Update de app om te genieten van de nieuwste functies et de beveiligingsfixes.';
	@override String get updateNow => 'Nu bijwerken';
	@override String get updateLater => 'Later';
	@override String get appUpToDate => 'App is up-to-date';
	@override String get checkUpdate => 'Controleren op updates';
}

/// The flat map containing all translations for locale <nl>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsNl {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'about.about' => 'Over',
			'about.createdBy' => 'Gemaakt door',
			'about.version' => 'Versie',
			'about.versionHistory' => 'Versiegeschiedenis',
			'about.about_intro1' => 'Als concertliefhebber heb ik EvntTrackr in eerste instantie voor mijn eigen behoeften gemaakt. Geen gedoe meer met het beheren van spreadsheets, maar een eenvoudige et gecentraliseerde ervaring.',
			'about.about_intro2' => 'Overtuigd dat de app ook nuttig zou kunnen zijn voor andere liefhebbers, heb ich besloten deze met jullie te delen.',
			'about.about_support_title' => 'Ondersteun de ontwikkeling',
			'about.about_feedback_text' => 'Jouw feedback is waardevol! Deel gerust je gedachten met mij:',
			'about.about_email_tooltip' => 'Stuur een e-mail',
			'about.about_instagram_tooltip' => 'Volg op Instagram',
			'about.about_donation_text' => 'Een klein gebaar voor een groot project. Als je wilt, kun je me steunen met een kopje koffie! ☕',
			'about.about_kofi_button' => 'Buy me a coffee',
			'about.about_paypal_button' => 'Doneren',
			'about.about_see_whatsnew' => 'Bekijk wat nieuwe',
			'about.rate_us' => 'App evalueren',
			'achievements.achievements_firstStep' => 'Eerste stap',
			'achievements.achievements_firstStepDescription' => 'Log je eerste evenement.',
			'achievements.achievements_rookieCollector' => 'Beginnende verzamelaar',
			'achievements.achievements_rookieCollectorDescription' => 'Registreer een artiest',
			'achievements.achievements_musicCritic' => 'Muziekcriticus',
			'achievements.achievements_musicCriticDescription' => 'Binnenkort beschikbaar',
			'achievements.achievements_curious' => 'Nieuwsgierig',
			'achievements.achievements_curiousDescription' => 'Bezoek je statistiekenpagina',
			'achievements.achievements_regular' => 'Regelmatig',
			'achievements.achievements_regularDescription' => 'Log 10 evenementen.',
			'achievements.achievements_pillar' => 'Pilaar',
			'achievements.achievements_pillarDescription' => 'Log 25 evenementen.',
			'achievements.achievements_headliner' => 'Headliner',
			'achievements.achievements_headlinerDescription' => 'Log 50 evenementen.',
			'achievements.achievements_musicPokedex' => 'Muziek Pokédex',
			'achievements.achievements_musicPokedexDescription' => 'Woon evenementen bij met 50 verschillende artiesten.',
			'achievements.achievements_trueFan' => 'Echte fan',
			'achievements.achievements_trueFanDescription' => 'Zie dezelfde artiest op 5 verschillende evenementen.',
			'achievements.achievements_superFan' => 'Superfan',
			'achievements.achievements_superFanDescription' => 'Zie dezelfde artiest op 10 verschillende evenementen.',
			'achievements.achievements_dieHardFan' => 'Die-hard fan',
			'achievements.achievements_dieHardFanDescription' => 'Zie dezelfde artiest op 15 different evenementen.',
			'achievements.achievements_loyal' => 'Loyaal',
			'achievements.achievements_loyalDescription' => 'Binnenkort beschikbaar',
			'achievements.achievements_marathoner' => 'Marathonloper',
			'achievements.achievements_marathonerDescription' => 'Binnenkort beschikbaar',
			'achievements.achievements_eclectic' => 'Eclectisch',
			'achievements.achievements_eclecticDescription' => 'Woon een concert en een festival bij.',
			'achievements.achievements_discoverer' => 'Ontdekker',
			'achievements.achievements_discovererDescription' => 'Binnenkort beschikbaar',
			'achievements.achievements_globetrotter' => 'Wereldreiziger',
			'achievements.achievements_globetrotterDescription' => 'Woon evenementen bij op minimaal 5 verschillende locaties.',
			'achievements.achievements_archaeologist' => 'Archeoloog',
			'achievements.achievements_archaeologistDescription' => 'Log een evenement van meer dan 5 jaar geleden.',
			'achievements.achievements_nightOwl' => 'Nachtbraker',
			'achievements.achievements_nightOwlDescription' => 'Registreer een evenement tussen 0u et 6u',
			'achievements.achievements_oops' => 'Oeps',
			'achievements.achievements_oopsDescription' => 'Verwijder een evenement',
			'achievements.achievements_summerFest' => 'Zomerfestival',
			'achievements.achievements_summerFestDescription' => 'Binnenkort beschikbaar',
			'achievements.achievements_liveLegend' => 'Live legende',
			'achievements.achievements_liveLegendDescription' => 'Log 100 evenementen.',
			'achievements.achievements_pioneer' => 'Pionier',
			'achievements.achievements_pioneerDescription' => 'Neem deel aan de EvntTrackr-bèta.',
			'achievements.achievements_venueRegular' => 'De Stamgast',
			'achievements.achievements_venueRegularDescription' => 'Bezoek 5 evenementen op dezelfde locatie.',
			'achievements.achievements_venuePillar' => 'Zaalpilaar',
			'achievements.achievements_venuePillarDescription' => 'Bezoek 10 evenementen op dezelfde locatie',
			'achievements.achievements_venueLegend' => 'Zaallegende',
			'achievements.achievements_venueLegendDescription' => 'Bezoek 15 evenementen op dezelfde locatie',
			'achievements.rarity_common' => 'Gewoon',
			'achievements.rarity_uncommon' => 'Ongewoon',
			'achievements.rarity_rare' => 'Zeldzaam',
			'achievements.rarity_epic' => 'Episch',
			'achievements.rarity_legendary' => 'Legendair',
			'artists.artist' => 'Artiest',
			'artists.artists' => 'Artiesten',
			'artists.addArtist' => 'Artiest toevoegen',
			'artists.viewArtist' => 'Bekijk artiest',
			'artists.rateArtist' => 'Beoordeel artiest',
			'artists.performanceRating' => 'Performance',
			'artists.setlistRatingLabel' => 'Setlist',
			'artists.soundQualityRating' => 'Geluidskwaliteit',
			'artists.globalReview' => 'Globale beoordeling',
			'artists.noArtistsForEvent' => 'Geen artiesten voor dit evenement.',
			'artists.headliner' => 'Headliner',
			'artists.ratingSaved' => 'Beoordeling succesvol opgeslagen',
			'artists.artistSortOrderHeadliner' => 'Headliners',
			'artists.artistSortOrderAZ' => 'A-Z',
			'artists.artistSortOrderZA' => 'Z-A',
			'auth.signIn' => 'Inloggen',
			'auth.signUp' => 'Aanmelden',
			'auth.dontHaveAccount' => 'Ik heb geen account',
			'auth.alreadyHaveAccount' => 'Ik heb al een account',
			'auth.forgotPassword' => 'Wachtwoord vergeten?',
			'auth.pleaseEnterYourEmail' => 'Vul je e-mailadres in',
			'auth.passwordResetLinkSent' => 'Een link voor wachtwoordherstel is naar je gemaild',
			'auth.email' => 'E-mail',
			'auth.password' => 'Wachtwoord',
			'auth.username' => 'Gebruikersnaam',
			'auth.confirmPassword' => 'Bevestig wachtwoord',
			'auth.welcome' => 'Welkom bij EvntTrackr 2.3.0!',
			'auth.welcomedescription' => 'Bedankt voor het gebruik van EvntTrackr! Ik zet me met hart et ziel in om een app te ontwikkelen die bij u past et waar ich zelf ook enthousiast over ben. De app bevindt zich nog in de testfase: uw feedback is essentieel om hem te verbeteren! Aarzel niet om mij uw mening te geven via de pagina ‘Over ons’. Veel plezier met ontdekken!',
			'auth.whatsnew' => 'Wat is nieuw?',
			'auth.moretocome' => 'Meer om te komen!',
			'auth.alwaysimproving' => 'EvntTrackr blijft verbeteren et brengt nieuwe manieren om van je evenementen te genieten. Aarzel niet om je feedback te delen via de \'Over\'-pagina 💪',
			'auth.letsgo' => 'Laten we gaan!',
			'auth.new1' => 'Online evenementen zoeken',
			'auth.new1description' => 'Vind je evenementen nog gemakkelijker met onze nieuwe online zoekopdracht die externe databases integreert!',
			'auth.new2' => 'Mis nooit meer iets',
			'auth.new2description' => 'Schakel evenementherinneringen in met nieuwe lokale meldingen, zodat u altijd op tijd bent.',
			'auth.new3' => 'Een stijlvol profiel',
			'auth.new3description' => 'Ontdek een verbeterde gebruikersinterface voor je profiel-, statistieken- en prestatiepagina\'s. Mooier en duidelijker!',
			'auth.acceptPrivacyPolicy' => 'Ik heb het privacybeleid gelezen en ga akkoord',
			'auth.confirmationEmailSent' => 'Bevestigingsmail verzonden',
			'common.cancel' => 'Annuleren',
			'common.send' => 'Verzenden',
			'common.close' => 'Sluiten',
			'common.reset' => 'Wissen',
			'common.create' => 'Aanmaken',
			'common.update' => 'Bijwerken',
			'common.save' => 'Opslaan',
			'common.delete' => 'Verwijderen',
			'common.next' => 'Volgende',
			'common.add' => 'Toevoegen',
			'common.search' => 'Mijn evenementen filteren...',
			'common.today' => 'Vandaag',
			'common.tomorrow' => 'Demain',
			'common.inDays' => ({required Object n}) => 'Over ${n} dagen',
			'common.dateRange' => ({required Object startDate, required Object endDate}) => 'Van ${startDate} tot ${endDate}',
			'common.pageOutOfTotal' => ({required Object currentPage, required Object totalPages}) => 'Pagina ${currentPage} van ${totalPages}',
			'common.noDataAvailable' => 'Geen gegevens beschikbaar',
			'common.seeAll' => 'Alles zien',
			'common.total' => 'Totaal',
			'common.rank' => '#',
			'common.seen' => 'Gezien',
			'common.thisYear' => 'Dit jaar',
			'errors.invalidPrice' => 'Voer een geldige prijs in.',
			'errors.pleaseEnterAUsername' => 'Voer een gebruikersnaam in',
			'errors.pleaseEnterAPassword' => 'Voer een wachtwoord in',
			'errors.pleaseConfirmYourPassword' => 'Bevestig uw wachtwoord',
			'errors.loginerror' => 'Fout bij het inloggen.',
			'errors.eventCreateError' => 'Fout bij het aanmaken van het evenement',
			'errors.eventUpdateError' => 'Fout bij het bijwerken van het evenement',
			'errors.artistAddError' => 'Fout bij het toevoegen van artiest',
			'errors.locationAddError' => 'Fout bij het toevoegen van de locatie',
			'errors.errorDeletingEvent' => 'Fout bij het verwijderen van evenement',
			'errors.error' => 'Fout',
			'errors.errorDetails' => 'Fout',
			'errors.errorUpdatingHeadlinerStatus' => 'Fout bij het bijwerken van de headlinerstatus.',
			'errors.pleaseAcceptPrivacyPolicy' => 'Accepteer het privacybeleid om door te gaan',
			'errors.passwordsDoNotMatch' => 'Wachtwoorden komen niet overeen',
			'errors.passwordTooShort' => 'Wachtwoord moet minimaal 6 tekens bevatten',
			'errors.passwordComplexity' => 'Wachtwoord moet minimaal een kleine, een grote et un cijfer bevatten',
			'errors.pleaseEnterNewPassword' => 'Voer een nieuw wachtwoord in',
			'errors.nameRequired' => 'Naam verplicht',
			'errors.locationRequired' => 'Selecteer een locatie',
			'errors.dateRequired' => 'Datum vereist',
			'errors.requiredField' => 'Verplicht',
			'errors.invalidNumber' => 'Ongeldig nummer',
			'events.events' => 'Events',
			'events.eventname' => 'Evenementennaam',
			'events.location' => 'Locatie',
			'events.start' => 'Begin',
			'events.end' => 'Einde',
			'events.datetime' => 'Datum en tijd',
			'events.gotmyticket' => 'Ik heb mijn ticket',
			'events.price' => 'Prijs',
			'events.eventtype' => 'Evenemententype',
			'events.festival' => 'Festival',
			'events.concert' => 'Concert',
			'events.createevent' => 'Evenement aanmaken',
			'events.editEvent' => 'Evenement bewerken',
			'events.editevent' => 'Evenement bewerken',
			'events.eventCreatedSuccess' => 'Evenement succesvol aangemaakt!',
			'events.eventUpdatedSuccess' => 'Evenement succesvol bijgewerkt!',
			'events.eventDeletedSuccessfully' => 'Evenement succesvol verwijderd.',
			'events.noEventDetailsFound' => 'Geen details gevonden voor dit evenement.',
			'events.deleteEvent' => 'Evenement verwijderen',
			'events.confirmDeletion' => 'Verwijdering bevestigen',
			'events.confirmDeleteEventMessage' => 'Weet u zeker dat u dit evenement wilt verwijderen? Deze action is onomkeerbaar.',
			'events.event_ongoing' => 'Bezig',
			'events.upcoming' => 'Aankomend',
			'events.past' => 'Verleden',
			'events.bookmarked' => 'Opgeslagen',
			'events.noupcoming' => 'Geen aanstaande evenementen.',
			'events.nopast' => 'Geen evenementen in het verleden.',
			'events.nobookmarked' => 'Geen opgeslagen evenementen.',
			'events.addToUpcoming' => 'Markeren als gekocht?',
			'events.addToUpcomingInfo' => 'Hiermee wordt het evenement verplaatst naar het tabblad \'Aankomend\'.',
			'events.eventAddedToUpcoming' => 'Evenement toegevoegd aan de lijst "Aankomend"',
			'events.priceWithCurrency' => 'Prijs (€)',
			'events.ticketPriceOptional' => 'Ticketprijs (optioneel)',
			'events.searchPlaceholder' => 'Zoek naar een evenement, een artiest...',
			'events.filterAroundMe' => 'Om me heen',
			'events.filterGenre' => 'Genre',
			'events.filterDate' => 'Filteren op datum',
			'events.unknownLocation' => 'Onbekende locatie',
			'events.artistsIncluded' => 'artiesten inbegrepen',
			'events.artistIncluded' => 'artiest inbegrepen',
			'events.noEventDetailsFoundDesc' => 'Geen zorgen, u kunt het handmatig aanmaken! (Locatie en artiesten worden voorgesteld)',
			'events.createManually' => 'Handmatig aanmaken',
			'events.searchOnlineTitle' => 'Online zoeken',
			'events.searchBetaDesc' => 'Functie in Beta: het is mogelijk dat sommige evenementen niet worden gevonden.',
			'notifications.titles.0' => 'Herinnering!',
			'notifications.titles.1' => 'Het is bijna zover!',
			'notifications.titles.2' => 'Maak je klaar!',
			'notifications.titles.3' => 'Aankomend evenement!',
			'notifications.withTicket' => ({required Object name, required Object time}) => '${name} vindt over ${time} plaats. Vergeet je ticket niet!',
			'notifications.withoutTicket' => ({required Object name, required Object time}) => '${name} vindt over ${time} plaats. Heb je je ticket al?',
			'notifications.details' => ({required Object date, required Object location}) => 'Datum: ${date} • Locatie: ${location}',
			'notifications.time1Week' => 'een week',
			'notifications.time24h' => '24 uur',
			'notifications.channelName' => 'Evenement Herinneringen',
			'notifications.channelDesc' => 'Meldingen om je te herinneren aan je aankomende evenementen',
			'onboarding.welcomeTitle' => 'Welkom!',
			'onboarding.welcomeSubtitle' => 'Laten we beginnen met het instellen van uw voorkeuren voor de beste ervaring.',
			'onboarding.languageTitle' => 'Taal',
			'onboarding.languageSubtitle' => 'Kies uw voorkeurstaal',
			'onboarding.themeTitle' => 'Thema',
			'onboarding.themeSubtitle' => 'Pas het uiterlijk van de app aan',
			'onboarding.dateFormatTitle' => 'Datumnotatie',
			'onboarding.dateFormatSubtitle' => 'Hoe leest u data het liefst?',
			'onboarding.readyTitle' => 'Alles klaar!',
			'onboarding.readySubtitle' => 'U hoeft alleen nog in te loggen of aan te melden om te beginnen!',
			'onboarding.next' => 'Volgende',
			'onboarding.start' => 'Starten',
			'onboarding.back' => 'Vorige',
			'onboarding.notificationsTitle' => 'Meldingen',
			'onboarding.notificationsSubtitle' => 'Mis geen van je evenementen',
			'privacy.privacyPolicy' => 'Privacybeleid',
			'privacy.privacyPolicyTitle' => 'Privacybeleid',
			'privacy.privacyPolicyContent' => 'Uw privacy is belangrijk voor ons.',
			'privacy.privacy_intro_title' => '1. Inleiding',
			'privacy.privacy_intro_body' => 'EvntTrackr zet zich in voor de bescherming van uw persoonlijke gegevens in overeenstemming met de Algemene Verordening Gegevensbescherming (AVG/GDPR). Dit beleid legt uit hoe we uw informatie verzamelen, gebruiken en beschermen.',
			'privacy.privacy_data_collected_title' => '2. Verzamelde gegevens',
			'privacy.privacy_data_collected_body' => 'Om EvntTrackr te gebruiken, moet u een account aanmaken met een e-mailadres et wachtwoord. Binnen de app kunt u evenementen maken met een locatie, datums en artiesten. We verzamelen nooit uw live locatie.',
			'privacy.privacy_use_of_data_title' => '3. Gebruik van gegevens',
			'privacy.privacy_use_of_data_body' => 'Uw gegevens worden alleen gebruikt om de functies van de app te bieden. We verkopen of teilen uw gegevens niet met derden.',
			'privacy.privacy_user_rights_title' => '4. Gebruikersrechten',
			'privacy.privacy_user_rights_body' => 'Onder de AVG heeft u de volgende rechten:',
			'privacy.privacy_user_rights_list1' => 'Toegang tot uw gegevens',
			'privacy.privacy_user_rights_list2' => 'Download uw gegevens (evenementen, notities, beoordelingen)',
			'privacy.privacy_user_rights_list3' => 'Verwijder uw gegevens of account',
			'privacy.privacy_user_rights_list4' => 'Corrigeer of wijzig uw informatie',
			'privacy.privacy_data_retention_title' => '5. Gegevensbewaring',
			'privacy.privacy_data_retention_body' => 'Uw gegevens worden bewaard zolang uw account actief is. U kunt uw account op elk gewenst moment verwijderen.',
			'privacy.privacy_contact_title' => '6. Contact',
			'privacy.privacy_contact_body' => 'Voor vragen over uw persoonlijke gegevens kunt u contact met ons opnemen via: evnt.trackr@gmail.com',
			'profile.profile' => 'Profil',
			'profile.memberSince' => 'Lid sinds',
			'profile.totalEvents' => 'Evenementen',
			'profile.totalArtists' => 'Artiesten',
			'profile.averageRating' => 'Average',
			'profile.viewMyStats' => 'Bekijk mijn statistieken',
			'profile.achievements' => 'Prestaties',
			'profile.lastEvent' => 'Laatste evenement',
			'profile.nextEvent' => 'Volgend evenement',
			'settings.settings' => 'Instellingen',
			'settings.preferences' => 'Voorkeuren',
			'settings.language' => 'Taal',
			'settings.dateFormat' => 'Datumnotatie',
			'settings.displayMode' => 'Weergavemodus',
			'settings.light' => 'Licht',
			'settings.dark' => 'Donker',
			'settings.system' => 'Systeem',
			'settings.account' => 'Account',
			'settings.changePassword' => 'Wachtwoord wijzigen',
			'settings.resetAccount' => 'Account resetten',
			'settings.resetAccountWarning' => 'Het resetten van je account verwijdert al je evenementen, beoordelingen en prestaties. Deze actie is onomkeerbaar.',
			'settings.deleteAccount' => 'Account verwijderen',
			'settings.deleteAccountWarning' => 'Het verwijderen van je account wist permanent al je informatie en je wordt uitgelogd. Deze actie is onomkeerbaar.',
			'settings.newPassword' => 'Nieuw wachtwoord',
			'settings.confirmNewPassword' => 'Bevestig nieuw wachtwoord',
			'settings.passwordChangedSuccessfully' => 'Wachtwoord succesvol gewijzigd',
			'settings.logout' => 'Uitloggen',
			'settings.profilsettings' => 'Profielinstellingen',
			'settings.editprofile' => 'Profiel wijzigen',
			'settings.profileUpdated' => 'Profiel bijgewerkt',
			'settings.app' => 'App',
			'settings.notif1WeekTitle' => 'Herinnering: 1 week vooraf',
			'settings.notif1WeekDesc' => 'Krijg 7 dagen voor het evenement een melding',
			'settings.notif1DayTitle' => 'Herinnering: 24 uur vooraf',
			'settings.notif1DayDesc' => 'Krijg de dag voor het evenement een melding',
			'settings.debugNotifTitle' => 'Debug: Bekijk meldingen',
			'settings.debugNoNotifs' => 'Geen geplande meldingen',
			'settings.debugPending' => 'Geplande meldingen',
			'stats.myStats' => 'Mijn Statistieken',
			'stats.totalPerformances' => 'Shows',
			'stats.mostSeenArtists' => 'Meest geziene artiesten',
			'stats.bestPerformances' => 'Beste optredens',
			'stats.festivals' => 'Festivals',
			'stats.concerts' => 'Concerten',
			'stats.eventDistribution' => 'Verdeling van evenementen',
			'stats.stats_before' => ({required Object minYearStr}) => 'Vóór ${minYearStr}',
			'stats.stats_email_subject' => '[Statistieken]',
			'stats.didntFindWhatYouWereLookingFor' => 'Niet gevonden wat je zocht?',
			'stats.tellUs' => 'Vertel het ons',
			'stats.expenses' => 'Uitgaven',
			'update.updateAvailable' => 'Update beschikbaar',
			'update.updateVersionReady' => ({required Object newVersion}) => 'Een nieuwe versie (${newVersion}) is beschikbaar!',
			'update.updateDescription' => 'Update de app om te genieten van de nieuwste functies et de beveiligingsfixes.',
			'update.updateNow' => 'Nu bijwerken',
			'update.updateLater' => 'Later',
			'update.appUpToDate' => 'App is up-to-date',
			'update.checkUpdate' => 'Controleren op updates',
			_ => null,
		};
	}
}
