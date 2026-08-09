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
class TranslationsFr extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsFr _root = this; // ignore: unused_field

	@override 
	TranslationsFr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFr(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsAboutFr about = _TranslationsAboutFr._(_root);
	@override late final _TranslationsAchievementsFr achievements = _TranslationsAchievementsFr._(_root);
	@override late final _TranslationsArtistsFr artists = _TranslationsArtistsFr._(_root);
	@override late final _TranslationsAuthFr auth = _TranslationsAuthFr._(_root);
	@override late final _TranslationsCommonFr common = _TranslationsCommonFr._(_root);
	@override late final _TranslationsErrorsFr errors = _TranslationsErrorsFr._(_root);
	@override late final _TranslationsEventsFr events = _TranslationsEventsFr._(_root);
	@override late final _TranslationsNotificationsFr notifications = _TranslationsNotificationsFr._(_root);
	@override late final _TranslationsOnboardingFr onboarding = _TranslationsOnboardingFr._(_root);
	@override late final _TranslationsPrivacyFr privacy = _TranslationsPrivacyFr._(_root);
	@override late final _TranslationsProfileFr profile = _TranslationsProfileFr._(_root);
	@override late final _TranslationsSettingsFr settings = _TranslationsSettingsFr._(_root);
	@override late final _TranslationsStatsFr stats = _TranslationsStatsFr._(_root);
	@override late final _TranslationsUpdateFr update = _TranslationsUpdateFr._(_root);
}

// Path: about
class _TranslationsAboutFr extends TranslationsAboutEn {
	_TranslationsAboutFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get about => 'À Propos';
	@override String get createdBy => 'Créé par';
	@override String get version => 'Version';
	@override String get versionHistory => 'Historique des versions';
	@override String get about_intro1 => 'Passionné de concerts, j\'ai d\'abord créé EvntTrackr pour mes propres besoins. Fini le casse-tête de la gestion sur tableur, place à une expérience simple et centralisée.';
	@override String get about_intro2 => 'Convaincu que l\'application pouvait servir à d\'autres passionnés, j\'ai décidé de la partager avec toi.';
	@override String get about_support_title => 'Soutenez le développement';
	@override String get about_feedback_text => 'Ton avis est précieux ! N\'hésite pas à me faire part de tes retours :';
	@override String get about_email_tooltip => 'Envoyer un mail';
	@override String get about_instagram_tooltip => 'Suivre sur Instagram';
	@override String get about_donation_text => 'Un petit geste pour un grand projet. Si le cœur t\'en dit, tu peux me soutenir avec un café ! ☕';
	@override String get about_kofi_button => 'Buy me a coffee';
	@override String get about_paypal_button => 'Faire un don';
	@override String get about_see_whatsnew => 'Revoir les nouveautés';
	@override String get rate_us => 'Noter l\'application';
}

// Path: achievements
class _TranslationsAchievementsFr extends TranslationsAchievementsEn {
	_TranslationsAchievementsFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get achievements_firstStep => 'Premiers Pas';
	@override String get achievements_firstStepDescription => 'Enregistre ton premier événement.';
	@override String get achievements_rookieCollector => 'Collectionneur Débutant';
	@override String get achievements_rookieCollectorDescription => 'Enregistre un artiste';
	@override String get achievements_musicCritic => 'Critique Musical';
	@override String get achievements_musicCriticDescription => 'À Venir';
	@override String get achievements_curious => 'Curieux';
	@override String get achievements_curiousDescription => 'Visite ta page de statistiques';
	@override String get achievements_regular => 'Régulier';
	@override String get achievements_regularDescription => 'Enregistre 10 événements.';
	@override String get achievements_pillar => 'Pilier';
	@override String get achievements_pillarDescription => 'Enregistre 25 événements.';
	@override String get achievements_headliner => 'Tête d\'Affiche';
	@override String get achievements_headlinerDescription => 'Enregistre 50 événements.';
	@override String get achievements_musicPokedex => 'Pokédex Musical';
	@override String get achievements_musicPokedexDescription => 'Assiste à des événements avec 50 artistes différents.';
	@override String get achievements_trueFan => 'Vrai Fan';
	@override String get achievements_trueFanDescription => 'Vois le même artiste lors de 5 événements différents.';
	@override String get achievements_superFan => 'Super Fan';
	@override String get achievements_superFanDescription => 'Vois le même artiste lors de 10 événements différents.';
	@override String get achievements_dieHardFan => 'Fan Inconditionnel';
	@override String get achievements_dieHardFanDescription => 'Vois le même artiste lors de 15 événements différents.';
	@override String get achievements_loyal => 'Loyal';
	@override String get achievements_loyalDescription => 'À Venir';
	@override String get achievements_marathoner => 'Marathonien';
	@override String get achievements_marathonerDescription => 'À Venir';
	@override String get achievements_eclectic => 'Éclectique';
	@override String get achievements_eclecticDescription => 'Assiste à un concert et à un festival.';
	@override String get achievements_discoverer => 'Découvreur';
	@override String get achievements_discovererDescription => 'À Venir';
	@override String get achievements_globetrotter => 'Globetrotter';
	@override String get achievements_globetrotterDescription => 'Assiste à des événements dans au moins 5 lieux différents.';
	@override String get achievements_archaeologist => 'Archéologue';
	@override String get achievements_archaeologistDescription => 'Enregistre un événement datant d\'il y a plus de 5 ans.';
	@override String get achievements_nightOwl => 'Oiseau de Nuit';
	@override String get achievements_nightOwlDescription => 'Enregistre un événement entre 0h et 6h';
	@override String get achievements_oops => 'Oups';
	@override String get achievements_oopsDescription => 'Supprime un événement';
	@override String get achievements_summerFest => 'Festival d\'Été';
	@override String get achievements_summerFestDescription => 'À Venir';
	@override String get achievements_liveLegend => 'Légende Vivante';
	@override String get achievements_liveLegendDescription => 'Enregistre 100 événements.';
	@override String get achievements_pioneer => 'Pionnier';
	@override String get achievements_pioneerDescription => 'Participe à la bêta d\'EvntTrackr.';
	@override String get achievements_venueRegular => 'L\'Habitué';
	@override String get achievements_venueRegularDescription => 'Assiste à 5 événements dans le même lieu.';
	@override String get achievements_venuePillar => 'Pilier de Salle';
	@override String get achievements_venuePillarDescription => 'Assiste à 10 événements dans le même lieu';
	@override String get achievements_venueLegend => 'Légende de Salle';
	@override String get achievements_venueLegendDescription => 'Assiste à 15 événements dans le même lieu';
	@override String get rarity_common => 'Commun';
	@override String get rarity_uncommon => 'Peu Commun';
	@override String get rarity_rare => 'Rare';
	@override String get rarity_epic => 'Épique';
	@override String get rarity_legendary => 'Légendaire';
}

// Path: artists
class _TranslationsArtistsFr extends TranslationsArtistsEn {
	_TranslationsArtistsFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get artist => 'Artiste';
	@override String get artists => 'Artistes';
	@override String get addArtist => 'Ajouter un artiste';
	@override String get viewArtist => 'Voir l\'artiste';
	@override String get rateArtist => 'Noter l\'artiste';
	@override String get performanceRating => 'Performance';
	@override String get setlistRatingLabel => 'Setlist';
	@override String get soundQualityRating => 'Qualité du son';
	@override String get globalReview => 'Avis global';
	@override String get noArtistsForEvent => 'Aucun artiste pour cet événement.';
	@override String get headliner => 'Tête d\'affiche';
	@override String get ratingSaved => 'Évaluation enregistrée';
	@override String get artistSortOrderHeadliner => 'Têtes d\'affiche';
	@override String get artistSortOrderAZ => 'A-Z';
	@override String get artistSortOrderZA => 'Z-A';
}

// Path: auth
class _TranslationsAuthFr extends TranslationsAuthEn {
	_TranslationsAuthFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get signIn => 'Me connecter';
	@override String get signUp => 'Je m\'inscris !';
	@override String get dontHaveAccount => 'Je n\'ai pas de compte';
	@override String get alreadyHaveAccount => 'J\'ai déjà un compte';
	@override String get forgotPassword => 'Mot de passe oublié ?';
	@override String get pleaseEnterYourEmail => 'Saisis ton adresse e-mail';
	@override String get passwordResetLinkSent => 'Un lien de réinitialisation t\'a été envoyé par e-mail';
	@override String get email => 'Email';
	@override String get password => 'Mot de passe';
	@override String get username => 'Nom d\'utilisateur';
	@override String get confirmPassword => 'Confirmer le mot de passe';
	@override String get welcome => 'EvntTrackr 2.3.0 est là !';
	@override String get welcomedescription => 'Merci d\'utiliser EvntTrackr ! Je mets tout mon cœur à construire une application qui vous ressemble autant qu\'elle me passionne. L\'application est encore en phase de test : vos retours sont essentiels pour l\'améliorer ! N\'hésitez pas à me les partager via the page « À Propos ». Bonne découverte !';
	@override String get whatsnew => 'Quoi de neuf ?';
	@override String get moretocome => 'Plus à venir !';
	@override String get alwaysimproving => 'EvntTrackr continue de s\'améliorer et d\'apporter de nouvelles façons de profiter de tes événements. N\'hésite pas à me faire part de tes impressions via la page À Propos 💪';
	@override String get letsgo => 'C\'est parti !';
	@override String get new1 => 'Recherche en ligne';
	@override String get new1description => 'Trouvez vos événements encore plus facilement grâce à notre nouvelle recherche en ligne qui intègre des bases de données externes !';
	@override String get new2 => 'Ne manquez plus rien';
	@override String get new2description => 'Activez les rappels d\'événements grâce aux nouvelles notifications locales pour être toujours à l\'heure.';
	@override String get new3 => 'Un profil qui a du style';
	@override String get new3description => 'Découvrez une interface améliorée pour vos pages de profil, de statistiques et d\'accomplissements. Plus beau, plus clair !';
	@override String get acceptPrivacyPolicy => 'J\'ai lu et j\'accepte la politique de confidentialité';
	@override String get confirmationEmailSent => 'E-mail de confirmation envoyé';
}

// Path: common
class _TranslationsCommonFr extends TranslationsCommonEn {
	_TranslationsCommonFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Annuler';
	@override String get send => 'Envoyer';
	@override String get close => 'Fermer';
	@override String get reset => 'Effacer';
	@override String get create => 'Créer';
	@override String get update => 'Mettre à jour';
	@override String get save => 'Enregistrer';
	@override String get delete => 'Supprimer';
	@override String get next => 'Suivant';
	@override String get add => 'Ajouter';
	@override String get search => 'Filtrer mes événements...';
	@override String get today => 'Aujourd\'hui';
	@override String get tomorrow => 'Demain';
	@override String inDays({required Object n}) => 'Dans ${n} jours';
	@override String dateRange({required Object startDate, required Object endDate}) => 'Du ${startDate} au ${endDate}';
	@override String pageOutOfTotal({required Object currentPage, required Object totalPages}) => 'Page ${currentPage} sur ${totalPages}';
	@override String get noDataAvailable => 'Aucune donnée disponible';
	@override String get seeAll => 'Voir tout';
	@override String get total => 'Total';
	@override String get rank => '#';
	@override String get seen => 'Vus';
	@override String get thisYear => 'Cette année';
}

// Path: errors
class _TranslationsErrorsFr extends TranslationsErrorsEn {
	_TranslationsErrorsFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get invalidPrice => 'Veuillez saisir un prix valide.';
	@override String get pleaseEnterAUsername => 'Veuillez saisir un nom d\'utilisateur';
	@override String get pleaseEnterAPassword => 'Veuillez saisir un mot de passe';
	@override String get pleaseConfirmYourPassword => 'Veuillez confirmer votre mot de passe';
	@override String get loginerror => 'Erreur lors de la tentative de connexion.';
	@override String get eventCreateError => 'Erreur lors de la création de l\'événement';
	@override String get eventUpdateError => 'Erreur lors de la mise à jour de l\'événement';
	@override String get artistAddError => 'Erreur lors de l\'ajout de l\'artiste';
	@override String get locationAddError => 'Erreur lors de l\'ajout du lieu';
	@override String get errorDeletingEvent => 'Erreur lors de la suppression de l\'événement.';
	@override String get error => 'Erreur';
	@override String get errorDetails => 'Erreur';
	@override String get errorUpdatingHeadlinerStatus => 'Erreur lors de la mise à jour du statut de la tête d\'affiche.';
	@override String get pleaseAcceptPrivacyPolicy => 'Veuillez accepter la politique de confidentialité pour continuer';
	@override String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas';
	@override String get passwordTooShort => 'Le mot de passe doit contenir au moins 6 caractères';
	@override String get passwordComplexity => 'Le mot de passe doit contenir au moins une minuscule, une majuscule et un chiffre';
	@override String get pleaseEnterNewPassword => 'Veuillez entrer un nouveau mot de passe';
	@override String get nameRequired => 'Nom obligatoire';
	@override String get locationRequired => 'Veuillez sélectionner un lieu';
	@override String get dateRequired => 'Date requise';
	@override String get requiredField => 'Requis';
	@override String get invalidNumber => 'Nombre invalide';
}

// Path: events
class _TranslationsEventsFr extends TranslationsEventsEn {
	_TranslationsEventsFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get events => 'Événements';
	@override String get eventname => 'Nom de l\'événement';
	@override String get location => 'Lieu';
	@override String get start => 'Début';
	@override String get end => 'Fin';
	@override String get datetime => 'Date et heure';
	@override String get gotmyticket => 'J\'ai mon billet';
	@override String get price => 'Prix';
	@override String get eventtype => 'Type d\'événement';
	@override String get festival => 'Festival';
	@override String get concert => 'Concert';
	@override String get createevent => 'Créer un événement';
	@override String get editEvent => 'Modifier l\'événement';
	@override String get editevent => 'Modifier un événement';
	@override String get eventCreatedSuccess => 'Événement créé';
	@override String get eventUpdatedSuccess => 'Événement mis à jour';
	@override String get eventDeletedSuccessfully => 'Événement supprimé';
	@override String get noEventDetailsFound => 'Aucun détail trouvé pour cet événement.';
	@override String get deleteEvent => 'Supprimer l\'événement';
	@override String get confirmDeletion => 'Confirmer la suppression';
	@override String get confirmDeleteEventMessage => 'Êtes-vous sûr de vouloir supprimer cet événement ? Cette action est irréversible.';
	@override String get event_ongoing => 'En cours';
	@override String get upcoming => 'À Venir';
	@override String get past => 'Passés';
	@override String get bookmarked => 'Enregistrés';
	@override String get noupcoming => 'Aucun événement à venir.';
	@override String get nopast => 'Aucun événement passé.';
	@override String get nobookmarked => 'Aucun événement enregistré.';
	@override String get addToUpcoming => 'Marquer comme acheté ?';
	@override String get addToUpcomingInfo => 'Cette action déplacera l\'événement dans l\'onglet \'À Venir\'.';
	@override String get eventAddedToUpcoming => 'Événement ajouté à la liste "À venir"';
	@override String get priceWithCurrency => 'Prix (€)';
	@override String get ticketPriceOptional => 'Prix du billet (facultatif)';
	@override String get searchPlaceholder => 'Rechercher un événement, un artiste...';
	@override String get filterAroundMe => 'Autour de moi';
	@override String get filterGenre => 'Genre';
	@override String get filterDate => 'Filtrer par date';
	@override String get unknownLocation => 'Lieu inconnu';
	@override String get artistsIncluded => 'artistes inclus';
	@override String get artistIncluded => 'artiste inclus';
	@override String get noEventDetailsFoundDesc => 'Pas de soucis, vous pouvez le créer manuellement ! (La salle et les artistes vous seront suggérés)';
	@override String get createManually => 'Créer manuellement';
	@override String get searchOnlineTitle => 'Recherche en ligne';
	@override String get searchBetaDesc => 'Fonctionnalité en Beta : il est possible que certains événements ne soient pas trouvés.';
}

// Path: notifications
class _TranslationsNotificationsFr extends TranslationsNotificationsEn {
	_TranslationsNotificationsFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override List<String> get titles => [
		'Rappel !',
		'C\'est pour bientôt !',
		'Prépare-toi !',
		'Événement en approche !',
	];
	@override String withTicket({required Object name, required Object time}) => '${name} a lieu dans ${time}. N\'oublie pas ton billet !';
	@override String withoutTicket({required Object name, required Object time}) => '${name} a lieu dans ${time}. As-tu pris ton billet ?';
	@override String details({required Object date, required Object location}) => 'Date : ${date} • Lieu : ${location}';
	@override String get time1Week => 'une semaine';
	@override String get time24h => '24 heures';
	@override String get channelName => 'Rappels d\'événements';
	@override String get channelDesc => 'Notifications pour te rappeler tes événements à venir';
}

// Path: onboarding
class _TranslationsOnboardingFr extends TranslationsOnboardingEn {
	_TranslationsOnboardingFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get welcomeTitle => 'Bienvenue !';
	@override String get welcomeSubtitle => 'Commençons par configurer tes préférences pour une expérience optimale.';
	@override String get languageTitle => 'Langue';
	@override String get languageSubtitle => 'Choisis ta langue préférée';
	@override String get themeTitle => 'Thème';
	@override String get themeSubtitle => 'Personnalise l\'apparence de l\'application';
	@override String get dateFormatTitle => 'Format des dates';
	@override String get dateFormatSubtitle => 'Comment préfères-tu lire les dates ?';
	@override String get readyTitle => 'Tout est prêt !';
	@override String get readySubtitle => 'Il ne te reste plus qu\'à te connecter ou créer un compte pour commencer !';
	@override String get next => 'Suivant';
	@override String get start => 'Commencer';
	@override String get back => 'Précédent';
	@override String get notificationsTitle => 'Notifications';
	@override String get notificationsSubtitle => 'Ne manque aucun de tes événements';
}

// Path: privacy
class _TranslationsPrivacyFr extends TranslationsPrivacyEn {
	_TranslationsPrivacyFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get privacyPolicy => 'Politique de confidentialité';
	@override String get privacyPolicyTitle => 'Politique de confidentialité';
	@override String get privacyPolicyContent => 'Votre vie privée est importante pour nous.';
	@override String get privacy_intro_title => '1. Introduction';
	@override String get privacy_intro_body => 'EvntTrackr s\'engage à protéger vos données personnelles conformément au Règlement Général sur la Protection des Données (RGPD). Cette politique explique comment nous collectons, utilisons et protégeons vos informations.';
	@override String get privacy_data_collected_title => '2. Données collectées';
	@override String get privacy_data_collected_body => 'Pour utiliser EvntTrackr, vous devez créer un compte avec une adresse e-mail et un mot de passe. Dans l\'application, vous pouvez créer des événements avec un lieu, des dates et des artistes. Nous ne collectons jamais votre position en direct.';
	@override String get privacy_use_of_data_title => '3. Utilisation des données';
	@override String get privacy_use_of_data_body => 'Vos données sont uniquement utilisées pour fournir les fonctionnalités de l\'application. Nous ne vendons ni ne partageons vos données avec des tiers.';
	@override String get privacy_user_rights_title => '4. Droits des utilisateurs';
	@override String get privacy_user_rights_body => 'En vertu du RGPD, vous disposez des droits suivants :';
	@override String get privacy_user_rights_list1 => 'Accéder à vos données';
	@override String get privacy_user_rights_list2 => 'Télécharger vos données (événements, notes, évaluations)';
	@override String get privacy_user_rights_list3 => 'Supprimer vos données ou votre compte';
	@override String get privacy_user_rights_list4 => 'Corriger ou modifier vos informations';
	@override String get privacy_data_retention_title => '5. Conservation des données';
	@override String get privacy_data_retention_body => 'Vos données sont conservées tant que votre compte est actif. Vous pouvez supprimer votre compte à tout moment.';
	@override String get privacy_contact_title => '6. Contact';
	@override String get privacy_contact_body => 'Pour toute question concernant vos données personnelles, veuillez nous contacter à l\'adresse : evnt.trackr@gmail.com';
}

// Path: profile
class _TranslationsProfileFr extends TranslationsProfileEn {
	_TranslationsProfileFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get profile => 'Profil';
	@override String get memberSince => 'Membre depuis';
	@override String get totalEvents => 'Événements';
	@override String get totalArtists => 'Artistes';
	@override String get averageRating => 'Moyenne';
	@override String get viewMyStats => 'Voir mes stats';
	@override String get achievements => 'Succès';
	@override String get lastEvent => 'Dernier événement';
	@override String get nextEvent => 'Prochain événement';
}

// Path: settings
class _TranslationsSettingsFr extends TranslationsSettingsEn {
	_TranslationsSettingsFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get settings => 'Paramètres';
	@override String get preferences => 'Préférences';
	@override String get language => 'Langue';
	@override String get dateFormat => 'Format de date';
	@override String get displayMode => 'Mode d\'affichage';
	@override String get light => 'Clair';
	@override String get dark => 'Sombre';
	@override String get system => 'Système';
	@override String get account => 'Compte';
	@override String get changePassword => 'Changer de mot de passe';
	@override String get resetAccount => 'Réinitialiser le compte';
	@override String get resetAccountWarning => 'La réinitialisation de ton compte supprimera tous tes événements, notes et succès. Cette action est irréversible.';
	@override String get deleteAccount => 'Supprimer le compte';
	@override String get deleteAccountWarning => 'La suppression de ton compte effacera définitivement toutes tes informations et tu seras déconnecté. Cette action est irréversible.';
	@override String get newPassword => 'Nouveau mot de passe';
	@override String get confirmNewPassword => 'Confirmer le nouveau mot de passe';
	@override String get passwordChangedSuccessfully => 'Mot de passe modifié';
	@override String get logout => 'Déconnexion';
	@override String get profilsettings => 'Paramètres du profil';
	@override String get editprofile => 'Éditer le profil';
	@override String get profileUpdated => 'Profil mis à jour';
	@override String get app => 'Application';
	@override String get notif1WeekTitle => 'Rappel : 1 semaine avant';
	@override String get notif1WeekDesc => 'Être notifié 7 jours avant l\'événement';
	@override String get notif1DayTitle => 'Rappel : 24 heures avant';
	@override String get notif1DayDesc => 'Être notifié la veille de l\'événement';
	@override String get debugNotifTitle => 'Debug : Voir les notifications';
	@override String get debugNoNotifs => 'Aucune notification programmée';
	@override String get debugPending => 'Notifications programmées';
}

// Path: stats
class _TranslationsStatsFr extends TranslationsStatsEn {
	_TranslationsStatsFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get myStats => 'Mes Statistiques';
	@override String get totalPerformances => 'Shows';
	@override String get mostSeenArtists => 'Artistes les plus vus';
	@override String get bestPerformances => 'Meilleures performances';
	@override String get festivals => 'Festivals';
	@override String get concerts => 'Concerts';
	@override String get eventDistribution => 'Répartition des événements';
	@override String stats_before({required Object minYearStr}) => 'Avant ${minYearStr}';
	@override String get stats_email_subject => '[Statistiques]';
	@override String get didntFindWhatYouWereLookingFor => 'Tu n\'as pas trouvé ce que tu cherchais ?';
	@override String get tellUs => 'Dis-le nous';
	@override String get expenses => 'Dépenses';
}

// Path: update
class _TranslationsUpdateFr extends TranslationsUpdateEn {
	_TranslationsUpdateFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get updateAvailable => 'Mise à jour disponible';
	@override String updateVersionReady({required Object newVersion}) => 'Une nouvelle version (${newVersion}) est disponible !';
	@override String get updateDescription => 'Mettez à jour l\'application pour profiter des dernières fonctionnalités et des corrections de sécurité.';
	@override String get updateNow => 'Mettre à jour';
	@override String get updateLater => 'Plus tard';
	@override String get appUpToDate => 'L\'application est à jour';
	@override String get checkUpdate => 'Vérifier les mises à jour';
}

/// The flat map containing all translations for locale <fr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'about.about' => 'À Propos',
			'about.createdBy' => 'Créé par',
			'about.version' => 'Version',
			'about.versionHistory' => 'Historique des versions',
			'about.about_intro1' => 'Passionné de concerts, j\'ai d\'abord créé EvntTrackr pour mes propres besoins. Fini le casse-tête de la gestion sur tableur, place à une expérience simple et centralisée.',
			'about.about_intro2' => 'Convaincu que l\'application pouvait servir à d\'autres passionnés, j\'ai décidé de la partager avec toi.',
			'about.about_support_title' => 'Soutenez le développement',
			'about.about_feedback_text' => 'Ton avis est précieux ! N\'hésite pas à me faire part de tes retours :',
			'about.about_email_tooltip' => 'Envoyer un mail',
			'about.about_instagram_tooltip' => 'Suivre sur Instagram',
			'about.about_donation_text' => 'Un petit geste pour un grand projet. Si le cœur t\'en dit, tu peux me soutenir avec un café ! ☕',
			'about.about_kofi_button' => 'Buy me a coffee',
			'about.about_paypal_button' => 'Faire un don',
			'about.about_see_whatsnew' => 'Revoir les nouveautés',
			'about.rate_us' => 'Noter l\'application',
			'achievements.achievements_firstStep' => 'Premiers Pas',
			'achievements.achievements_firstStepDescription' => 'Enregistre ton premier événement.',
			'achievements.achievements_rookieCollector' => 'Collectionneur Débutant',
			'achievements.achievements_rookieCollectorDescription' => 'Enregistre un artiste',
			'achievements.achievements_musicCritic' => 'Critique Musical',
			'achievements.achievements_musicCriticDescription' => 'À Venir',
			'achievements.achievements_curious' => 'Curieux',
			'achievements.achievements_curiousDescription' => 'Visite ta page de statistiques',
			'achievements.achievements_regular' => 'Régulier',
			'achievements.achievements_regularDescription' => 'Enregistre 10 événements.',
			'achievements.achievements_pillar' => 'Pilier',
			'achievements.achievements_pillarDescription' => 'Enregistre 25 événements.',
			'achievements.achievements_headliner' => 'Tête d\'Affiche',
			'achievements.achievements_headlinerDescription' => 'Enregistre 50 événements.',
			'achievements.achievements_musicPokedex' => 'Pokédex Musical',
			'achievements.achievements_musicPokedexDescription' => 'Assiste à des événements avec 50 artistes différents.',
			'achievements.achievements_trueFan' => 'Vrai Fan',
			'achievements.achievements_trueFanDescription' => 'Vois le même artiste lors de 5 événements différents.',
			'achievements.achievements_superFan' => 'Super Fan',
			'achievements.achievements_superFanDescription' => 'Vois le même artiste lors de 10 événements différents.',
			'achievements.achievements_dieHardFan' => 'Fan Inconditionnel',
			'achievements.achievements_dieHardFanDescription' => 'Vois le même artiste lors de 15 événements différents.',
			'achievements.achievements_loyal' => 'Loyal',
			'achievements.achievements_loyalDescription' => 'À Venir',
			'achievements.achievements_marathoner' => 'Marathonien',
			'achievements.achievements_marathonerDescription' => 'À Venir',
			'achievements.achievements_eclectic' => 'Éclectique',
			'achievements.achievements_eclecticDescription' => 'Assiste à un concert et à un festival.',
			'achievements.achievements_discoverer' => 'Découvreur',
			'achievements.achievements_discovererDescription' => 'À Venir',
			'achievements.achievements_globetrotter' => 'Globetrotter',
			'achievements.achievements_globetrotterDescription' => 'Assiste à des événements dans au moins 5 lieux différents.',
			'achievements.achievements_archaeologist' => 'Archéologue',
			'achievements.achievements_archaeologistDescription' => 'Enregistre un événement datant d\'il y a plus de 5 ans.',
			'achievements.achievements_nightOwl' => 'Oiseau de Nuit',
			'achievements.achievements_nightOwlDescription' => 'Enregistre un événement entre 0h et 6h',
			'achievements.achievements_oops' => 'Oups',
			'achievements.achievements_oopsDescription' => 'Supprime un événement',
			'achievements.achievements_summerFest' => 'Festival d\'Été',
			'achievements.achievements_summerFestDescription' => 'À Venir',
			'achievements.achievements_liveLegend' => 'Légende Vivante',
			'achievements.achievements_liveLegendDescription' => 'Enregistre 100 événements.',
			'achievements.achievements_pioneer' => 'Pionnier',
			'achievements.achievements_pioneerDescription' => 'Participe à la bêta d\'EvntTrackr.',
			'achievements.achievements_venueRegular' => 'L\'Habitué',
			'achievements.achievements_venueRegularDescription' => 'Assiste à 5 événements dans le même lieu.',
			'achievements.achievements_venuePillar' => 'Pilier de Salle',
			'achievements.achievements_venuePillarDescription' => 'Assiste à 10 événements dans le même lieu',
			'achievements.achievements_venueLegend' => 'Légende de Salle',
			'achievements.achievements_venueLegendDescription' => 'Assiste à 15 événements dans le même lieu',
			'achievements.rarity_common' => 'Commun',
			'achievements.rarity_uncommon' => 'Peu Commun',
			'achievements.rarity_rare' => 'Rare',
			'achievements.rarity_epic' => 'Épique',
			'achievements.rarity_legendary' => 'Légendaire',
			'artists.artist' => 'Artiste',
			'artists.artists' => 'Artistes',
			'artists.addArtist' => 'Ajouter un artiste',
			'artists.viewArtist' => 'Voir l\'artiste',
			'artists.rateArtist' => 'Noter l\'artiste',
			'artists.performanceRating' => 'Performance',
			'artists.setlistRatingLabel' => 'Setlist',
			'artists.soundQualityRating' => 'Qualité du son',
			'artists.globalReview' => 'Avis global',
			'artists.noArtistsForEvent' => 'Aucun artiste pour cet événement.',
			'artists.headliner' => 'Tête d\'affiche',
			'artists.ratingSaved' => 'Évaluation enregistrée',
			'artists.artistSortOrderHeadliner' => 'Têtes d\'affiche',
			'artists.artistSortOrderAZ' => 'A-Z',
			'artists.artistSortOrderZA' => 'Z-A',
			'auth.signIn' => 'Me connecter',
			'auth.signUp' => 'Je m\'inscris !',
			'auth.dontHaveAccount' => 'Je n\'ai pas de compte',
			'auth.alreadyHaveAccount' => 'J\'ai déjà un compte',
			'auth.forgotPassword' => 'Mot de passe oublié ?',
			'auth.pleaseEnterYourEmail' => 'Saisis ton adresse e-mail',
			'auth.passwordResetLinkSent' => 'Un lien de réinitialisation t\'a été envoyé par e-mail',
			'auth.email' => 'Email',
			'auth.password' => 'Mot de passe',
			'auth.username' => 'Nom d\'utilisateur',
			'auth.confirmPassword' => 'Confirmer le mot de passe',
			'auth.welcome' => 'EvntTrackr 2.3.0 est là !',
			'auth.welcomedescription' => 'Merci d\'utiliser EvntTrackr ! Je mets tout mon cœur à construire une application qui vous ressemble autant qu\'elle me passionne. L\'application est encore en phase de test : vos retours sont essentiels pour l\'améliorer ! N\'hésitez pas à me les partager via the page « À Propos ». Bonne découverte !',
			'auth.whatsnew' => 'Quoi de neuf ?',
			'auth.moretocome' => 'Plus à venir !',
			'auth.alwaysimproving' => 'EvntTrackr continue de s\'améliorer et d\'apporter de nouvelles façons de profiter de tes événements. N\'hésite pas à me faire part de tes impressions via la page À Propos 💪',
			'auth.letsgo' => 'C\'est parti !',
			'auth.new1' => 'Recherche en ligne',
			'auth.new1description' => 'Trouvez vos événements encore plus facilement grâce à notre nouvelle recherche en ligne qui intègre des bases de données externes !',
			'auth.new2' => 'Ne manquez plus rien',
			'auth.new2description' => 'Activez les rappels d\'événements grâce aux nouvelles notifications locales pour être toujours à l\'heure.',
			'auth.new3' => 'Un profil qui a du style',
			'auth.new3description' => 'Découvrez une interface améliorée pour vos pages de profil, de statistiques et d\'accomplissements. Plus beau, plus clair !',
			'auth.acceptPrivacyPolicy' => 'J\'ai lu et j\'accepte la politique de confidentialité',
			'auth.confirmationEmailSent' => 'E-mail de confirmation envoyé',
			'common.cancel' => 'Annuler',
			'common.send' => 'Envoyer',
			'common.close' => 'Fermer',
			'common.reset' => 'Effacer',
			'common.create' => 'Créer',
			'common.update' => 'Mettre à jour',
			'common.save' => 'Enregistrer',
			'common.delete' => 'Supprimer',
			'common.next' => 'Suivant',
			'common.add' => 'Ajouter',
			'common.search' => 'Filtrer mes événements...',
			'common.today' => 'Aujourd\'hui',
			'common.tomorrow' => 'Demain',
			'common.inDays' => ({required Object n}) => 'Dans ${n} jours',
			'common.dateRange' => ({required Object startDate, required Object endDate}) => 'Du ${startDate} au ${endDate}',
			'common.pageOutOfTotal' => ({required Object currentPage, required Object totalPages}) => 'Page ${currentPage} sur ${totalPages}',
			'common.noDataAvailable' => 'Aucune donnée disponible',
			'common.seeAll' => 'Voir tout',
			'common.total' => 'Total',
			'common.rank' => '#',
			'common.seen' => 'Vus',
			'common.thisYear' => 'Cette année',
			'errors.invalidPrice' => 'Veuillez saisir un prix valide.',
			'errors.pleaseEnterAUsername' => 'Veuillez saisir un nom d\'utilisateur',
			'errors.pleaseEnterAPassword' => 'Veuillez saisir un mot de passe',
			'errors.pleaseConfirmYourPassword' => 'Veuillez confirmer votre mot de passe',
			'errors.loginerror' => 'Erreur lors de la tentative de connexion.',
			'errors.eventCreateError' => 'Erreur lors de la création de l\'événement',
			'errors.eventUpdateError' => 'Erreur lors de la mise à jour de l\'événement',
			'errors.artistAddError' => 'Erreur lors de l\'ajout de l\'artiste',
			'errors.locationAddError' => 'Erreur lors de l\'ajout du lieu',
			'errors.errorDeletingEvent' => 'Erreur lors de la suppression de l\'événement.',
			'errors.error' => 'Erreur',
			'errors.errorDetails' => 'Erreur',
			'errors.errorUpdatingHeadlinerStatus' => 'Erreur lors de la mise à jour du statut de la tête d\'affiche.',
			'errors.pleaseAcceptPrivacyPolicy' => 'Veuillez accepter la politique de confidentialité pour continuer',
			'errors.passwordsDoNotMatch' => 'Les mots de passe ne correspondent pas',
			'errors.passwordTooShort' => 'Le mot de passe doit contenir au moins 6 caractères',
			'errors.passwordComplexity' => 'Le mot de passe doit contenir au moins une minuscule, une majuscule et un chiffre',
			'errors.pleaseEnterNewPassword' => 'Veuillez entrer un nouveau mot de passe',
			'errors.nameRequired' => 'Nom obligatoire',
			'errors.locationRequired' => 'Veuillez sélectionner un lieu',
			'errors.dateRequired' => 'Date requise',
			'errors.requiredField' => 'Requis',
			'errors.invalidNumber' => 'Nombre invalide',
			'events.events' => 'Événements',
			'events.eventname' => 'Nom de l\'événement',
			'events.location' => 'Lieu',
			'events.start' => 'Début',
			'events.end' => 'Fin',
			'events.datetime' => 'Date et heure',
			'events.gotmyticket' => 'J\'ai mon billet',
			'events.price' => 'Prix',
			'events.eventtype' => 'Type d\'événement',
			'events.festival' => 'Festival',
			'events.concert' => 'Concert',
			'events.createevent' => 'Créer un événement',
			'events.editEvent' => 'Modifier l\'événement',
			'events.editevent' => 'Modifier un événement',
			'events.eventCreatedSuccess' => 'Événement créé',
			'events.eventUpdatedSuccess' => 'Événement mis à jour',
			'events.eventDeletedSuccessfully' => 'Événement supprimé',
			'events.noEventDetailsFound' => 'Aucun détail trouvé pour cet événement.',
			'events.deleteEvent' => 'Supprimer l\'événement',
			'events.confirmDeletion' => 'Confirmer la suppression',
			'events.confirmDeleteEventMessage' => 'Êtes-vous sûr de vouloir supprimer cet événement ? Cette action est irréversible.',
			'events.event_ongoing' => 'En cours',
			'events.upcoming' => 'À Venir',
			'events.past' => 'Passés',
			'events.bookmarked' => 'Enregistrés',
			'events.noupcoming' => 'Aucun événement à venir.',
			'events.nopast' => 'Aucun événement passé.',
			'events.nobookmarked' => 'Aucun événement enregistré.',
			'events.addToUpcoming' => 'Marquer comme acheté ?',
			'events.addToUpcomingInfo' => 'Cette action déplacera l\'événement dans l\'onglet \'À Venir\'.',
			'events.eventAddedToUpcoming' => 'Événement ajouté à la liste "À venir"',
			'events.priceWithCurrency' => 'Prix (€)',
			'events.ticketPriceOptional' => 'Prix du billet (facultatif)',
			'events.searchPlaceholder' => 'Rechercher un événement, un artiste...',
			'events.filterAroundMe' => 'Autour de moi',
			'events.filterGenre' => 'Genre',
			'events.filterDate' => 'Filtrer par date',
			'events.unknownLocation' => 'Lieu inconnu',
			'events.artistsIncluded' => 'artistes inclus',
			'events.artistIncluded' => 'artiste inclus',
			'events.noEventDetailsFoundDesc' => 'Pas de soucis, vous pouvez le créer manuellement ! (La salle et les artistes vous seront suggérés)',
			'events.createManually' => 'Créer manuellement',
			'events.searchOnlineTitle' => 'Recherche en ligne',
			'events.searchBetaDesc' => 'Fonctionnalité en Beta : il est possible que certains événements ne soient pas trouvés.',
			'notifications.titles.0' => 'Rappel !',
			'notifications.titles.1' => 'C\'est pour bientôt !',
			'notifications.titles.2' => 'Prépare-toi !',
			'notifications.titles.3' => 'Événement en approche !',
			'notifications.withTicket' => ({required Object name, required Object time}) => '${name} a lieu dans ${time}. N\'oublie pas ton billet !',
			'notifications.withoutTicket' => ({required Object name, required Object time}) => '${name} a lieu dans ${time}. As-tu pris ton billet ?',
			'notifications.details' => ({required Object date, required Object location}) => 'Date : ${date} • Lieu : ${location}',
			'notifications.time1Week' => 'une semaine',
			'notifications.time24h' => '24 heures',
			'notifications.channelName' => 'Rappels d\'événements',
			'notifications.channelDesc' => 'Notifications pour te rappeler tes événements à venir',
			'onboarding.welcomeTitle' => 'Bienvenue !',
			'onboarding.welcomeSubtitle' => 'Commençons par configurer tes préférences pour une expérience optimale.',
			'onboarding.languageTitle' => 'Langue',
			'onboarding.languageSubtitle' => 'Choisis ta langue préférée',
			'onboarding.themeTitle' => 'Thème',
			'onboarding.themeSubtitle' => 'Personnalise l\'apparence de l\'application',
			'onboarding.dateFormatTitle' => 'Format des dates',
			'onboarding.dateFormatSubtitle' => 'Comment préfères-tu lire les dates ?',
			'onboarding.readyTitle' => 'Tout est prêt !',
			'onboarding.readySubtitle' => 'Il ne te reste plus qu\'à te connecter ou créer un compte pour commencer !',
			'onboarding.next' => 'Suivant',
			'onboarding.start' => 'Commencer',
			'onboarding.back' => 'Précédent',
			'onboarding.notificationsTitle' => 'Notifications',
			'onboarding.notificationsSubtitle' => 'Ne manque aucun de tes événements',
			'privacy.privacyPolicy' => 'Politique de confidentialité',
			'privacy.privacyPolicyTitle' => 'Politique de confidentialité',
			'privacy.privacyPolicyContent' => 'Votre vie privée est importante pour nous.',
			'privacy.privacy_intro_title' => '1. Introduction',
			'privacy.privacy_intro_body' => 'EvntTrackr s\'engage à protéger vos données personnelles conformément au Règlement Général sur la Protection des Données (RGPD). Cette politique explique comment nous collectons, utilisons et protégeons vos informations.',
			'privacy.privacy_data_collected_title' => '2. Données collectées',
			'privacy.privacy_data_collected_body' => 'Pour utiliser EvntTrackr, vous devez créer un compte avec une adresse e-mail et un mot de passe. Dans l\'application, vous pouvez créer des événements avec un lieu, des dates et des artistes. Nous ne collectons jamais votre position en direct.',
			'privacy.privacy_use_of_data_title' => '3. Utilisation des données',
			'privacy.privacy_use_of_data_body' => 'Vos données sont uniquement utilisées pour fournir les fonctionnalités de l\'application. Nous ne vendons ni ne partageons vos données avec des tiers.',
			'privacy.privacy_user_rights_title' => '4. Droits des utilisateurs',
			'privacy.privacy_user_rights_body' => 'En vertu du RGPD, vous disposez des droits suivants :',
			'privacy.privacy_user_rights_list1' => 'Accéder à vos données',
			'privacy.privacy_user_rights_list2' => 'Télécharger vos données (événements, notes, évaluations)',
			'privacy.privacy_user_rights_list3' => 'Supprimer vos données ou votre compte',
			'privacy.privacy_user_rights_list4' => 'Corriger ou modifier vos informations',
			'privacy.privacy_data_retention_title' => '5. Conservation des données',
			'privacy.privacy_data_retention_body' => 'Vos données sont conservées tant que votre compte est actif. Vous pouvez supprimer votre compte à tout moment.',
			'privacy.privacy_contact_title' => '6. Contact',
			'privacy.privacy_contact_body' => 'Pour toute question concernant vos données personnelles, veuillez nous contacter à l\'adresse : evnt.trackr@gmail.com',
			'profile.profile' => 'Profil',
			'profile.memberSince' => 'Membre depuis',
			'profile.totalEvents' => 'Événements',
			'profile.totalArtists' => 'Artistes',
			'profile.averageRating' => 'Moyenne',
			'profile.viewMyStats' => 'Voir mes stats',
			'profile.achievements' => 'Succès',
			'profile.lastEvent' => 'Dernier événement',
			'profile.nextEvent' => 'Prochain événement',
			'settings.settings' => 'Paramètres',
			'settings.preferences' => 'Préférences',
			'settings.language' => 'Langue',
			'settings.dateFormat' => 'Format de date',
			'settings.displayMode' => 'Mode d\'affichage',
			'settings.light' => 'Clair',
			'settings.dark' => 'Sombre',
			'settings.system' => 'Système',
			'settings.account' => 'Compte',
			'settings.changePassword' => 'Changer de mot de passe',
			'settings.resetAccount' => 'Réinitialiser le compte',
			'settings.resetAccountWarning' => 'La réinitialisation de ton compte supprimera tous tes événements, notes et succès. Cette action est irréversible.',
			'settings.deleteAccount' => 'Supprimer le compte',
			'settings.deleteAccountWarning' => 'La suppression de ton compte effacera définitivement toutes tes informations et tu seras déconnecté. Cette action est irréversible.',
			'settings.newPassword' => 'Nouveau mot de passe',
			'settings.confirmNewPassword' => 'Confirmer le nouveau mot de passe',
			'settings.passwordChangedSuccessfully' => 'Mot de passe modifié',
			'settings.logout' => 'Déconnexion',
			'settings.profilsettings' => 'Paramètres du profil',
			'settings.editprofile' => 'Éditer le profil',
			'settings.profileUpdated' => 'Profil mis à jour',
			'settings.app' => 'Application',
			'settings.notif1WeekTitle' => 'Rappel : 1 semaine avant',
			'settings.notif1WeekDesc' => 'Être notifié 7 jours avant l\'événement',
			'settings.notif1DayTitle' => 'Rappel : 24 heures avant',
			'settings.notif1DayDesc' => 'Être notifié la veille de l\'événement',
			'settings.debugNotifTitle' => 'Debug : Voir les notifications',
			'settings.debugNoNotifs' => 'Aucune notification programmée',
			'settings.debugPending' => 'Notifications programmées',
			'stats.myStats' => 'Mes Statistiques',
			'stats.totalPerformances' => 'Shows',
			'stats.mostSeenArtists' => 'Artistes les plus vus',
			'stats.bestPerformances' => 'Meilleures performances',
			'stats.festivals' => 'Festivals',
			'stats.concerts' => 'Concerts',
			'stats.eventDistribution' => 'Répartition des événements',
			'stats.stats_before' => ({required Object minYearStr}) => 'Avant ${minYearStr}',
			'stats.stats_email_subject' => '[Statistiques]',
			'stats.didntFindWhatYouWereLookingFor' => 'Tu n\'as pas trouvé ce que tu cherchais ?',
			'stats.tellUs' => 'Dis-le nous',
			'stats.expenses' => 'Dépenses',
			'update.updateAvailable' => 'Mise à jour disponible',
			'update.updateVersionReady' => ({required Object newVersion}) => 'Une nouvelle version (${newVersion}) est disponible !',
			'update.updateDescription' => 'Mettez à jour l\'application pour profiter des dernières fonctionnalités et des corrections de sécurité.',
			'update.updateNow' => 'Mettre à jour',
			'update.updateLater' => 'Plus tard',
			'update.appUpToDate' => 'L\'application est à jour',
			'update.checkUpdate' => 'Vérifier les mises à jour',
			_ => null,
		};
	}
}
