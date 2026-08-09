///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsAboutEn about = TranslationsAboutEn.internal(_root);
	late final TranslationsAchievementsEn achievements = TranslationsAchievementsEn.internal(_root);
	late final TranslationsArtistsEn artists = TranslationsArtistsEn.internal(_root);
	late final TranslationsAuthEn auth = TranslationsAuthEn.internal(_root);
	late final TranslationsCommonEn common = TranslationsCommonEn.internal(_root);
	late final TranslationsErrorsEn errors = TranslationsErrorsEn.internal(_root);
	late final TranslationsEventsEn events = TranslationsEventsEn.internal(_root);
	late final TranslationsNotificationsEn notifications = TranslationsNotificationsEn.internal(_root);
	late final TranslationsOnboardingEn onboarding = TranslationsOnboardingEn.internal(_root);
	late final TranslationsPrivacyEn privacy = TranslationsPrivacyEn.internal(_root);
	late final TranslationsProfileEn profile = TranslationsProfileEn.internal(_root);
	late final TranslationsSettingsEn settings = TranslationsSettingsEn.internal(_root);
	late final TranslationsStatsEn stats = TranslationsStatsEn.internal(_root);
	late final TranslationsUpdateEn update = TranslationsUpdateEn.internal(_root);
}

// Path: about
class TranslationsAboutEn {
	TranslationsAboutEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'About'
	String get about => 'About';

	/// en: 'Created by'
	String get createdBy => 'Created by';

	/// en: 'Version'
	String get version => 'Version';

	/// en: 'Version History'
	String get versionHistory => 'Version History';

	/// en: 'As a concert enthusiast, I initially created EvntTrackr for my own needs. No more spreadsheet management headaches, just a simple and centralized experience.'
	String get about_intro1 => 'As a concert enthusiast, I initially created EvntTrackr for my own needs. No more spreadsheet management headaches, just a simple and centralized experience.';

	/// en: 'Convinced that the app could be useful to other enthusiasts, I decided to share it with you.'
	String get about_intro2 => 'Convinced that the app could be useful to other enthusiasts, I decided to share it with you.';

	/// en: 'Support the development'
	String get about_support_title => 'Support the development';

	/// en: 'Your feedback is precious! Feel free to share your thoughts with me:'
	String get about_feedback_text => 'Your feedback is precious! Feel free to share your thoughts with me:';

	/// en: 'Send an email'
	String get about_email_tooltip => 'Send an email';

	/// en: 'Follow on Instagram'
	String get about_instagram_tooltip => 'Follow on Instagram';

	/// en: 'A small gesture for a big project. If you're so inclined, you can support me with a coffee! ☕'
	String get about_donation_text => 'A small gesture for a big project. If you\'re so inclined, you can support me with a coffee! ☕';

	/// en: 'Buy me a coffee'
	String get about_kofi_button => 'Buy me a coffee';

	/// en: 'Donate'
	String get about_paypal_button => 'Donate';

	/// en: 'See what's new'
	String get about_see_whatsnew => 'See what\'s new';

	/// en: 'Rate the app'
	String get rate_us => 'Rate the app';
}

// Path: achievements
class TranslationsAchievementsEn {
	TranslationsAchievementsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'First Step'
	String get achievements_firstStep => 'First Step';

	/// en: 'Log your first event.'
	String get achievements_firstStepDescription => 'Log your first event.';

	/// en: 'Rookie Collector'
	String get achievements_rookieCollector => 'Rookie Collector';

	/// en: 'Record an artist'
	String get achievements_rookieCollectorDescription => 'Record an artist';

	/// en: 'Music Critic'
	String get achievements_musicCritic => 'Music Critic';

	/// en: 'Coming soon'
	String get achievements_musicCriticDescription => 'Coming soon';

	/// en: 'Curious'
	String get achievements_curious => 'Curious';

	/// en: 'Visit your statistics page'
	String get achievements_curiousDescription => 'Visit your statistics page';

	/// en: 'Regular'
	String get achievements_regular => 'Regular';

	/// en: 'Log 10 events.'
	String get achievements_regularDescription => 'Log 10 events.';

	/// en: 'Pillar'
	String get achievements_pillar => 'Pillar';

	/// en: 'Log 25 events.'
	String get achievements_pillarDescription => 'Log 25 events.';

	/// en: 'Headliner'
	String get achievements_headliner => 'Headliner';

	/// en: 'Log 50 events.'
	String get achievements_headlinerDescription => 'Log 50 events.';

	/// en: 'Music Pokedex'
	String get achievements_musicPokedex => 'Music Pokedex';

	/// en: 'Attend events with 50 different artists.'
	String get achievements_musicPokedexDescription => 'Attend events with 50 different artists.';

	/// en: 'True Fan'
	String get achievements_trueFan => 'True Fan';

	/// en: 'See the same artist at 5 different events.'
	String get achievements_trueFanDescription => 'See the same artist at 5 different events.';

	/// en: 'Super Fan'
	String get achievements_superFan => 'Super Fan';

	/// en: 'See the same artist at 10 different events.'
	String get achievements_superFanDescription => 'See the same artist at 10 different events.';

	/// en: 'Die-Hard Fan'
	String get achievements_dieHardFan => 'Die-Hard Fan';

	/// en: 'See the same artist at 15 different events.'
	String get achievements_dieHardFanDescription => 'See the same artist at 15 different events.';

	/// en: 'Loyal'
	String get achievements_loyal => 'Loyal';

	/// en: 'Coming soon'
	String get achievements_loyalDescription => 'Coming soon';

	/// en: 'Marathoner'
	String get achievements_marathoner => 'Marathoner';

	/// en: 'Coming soon'
	String get achievements_marathonerDescription => 'Coming soon';

	/// en: 'Eclectic'
	String get achievements_eclectic => 'Eclectic';

	/// en: 'Attend a concert and a festival.'
	String get achievements_eclecticDescription => 'Attend a concert and a festival.';

	/// en: 'Discoverer'
	String get achievements_discoverer => 'Discoverer';

	/// en: 'Coming soon'
	String get achievements_discovererDescription => 'Coming soon';

	/// en: 'Globetrotter'
	String get achievements_globetrotter => 'Globetrotter';

	/// en: 'Attend events in at least 5 different locations.'
	String get achievements_globetrotterDescription => 'Attend events in at least 5 different locations.';

	/// en: 'Archaeologist'
	String get achievements_archaeologist => 'Archaeologist';

	/// en: 'Log an event from more than 5 years ago.'
	String get achievements_archaeologistDescription => 'Log an event from more than 5 years ago.';

	/// en: 'Night Owl'
	String get achievements_nightOwl => 'Night Owl';

	/// en: 'Record an event between 12 AM and 6 AM'
	String get achievements_nightOwlDescription => 'Record an event between 12 AM and 6 AM';

	/// en: 'Oops'
	String get achievements_oops => 'Oops';

	/// en: 'Delete an event.'
	String get achievements_oopsDescription => 'Delete an event.';

	/// en: 'Summer Fest'
	String get achievements_summerFest => 'Summer Fest';

	/// en: 'Coming soon'
	String get achievements_summerFestDescription => 'Coming soon';

	/// en: 'Live Legend'
	String get achievements_liveLegend => 'Live Legend';

	/// en: 'Log 100 events.'
	String get achievements_liveLegendDescription => 'Log 100 events.';

	/// en: 'Pioneer'
	String get achievements_pioneer => 'Pioneer';

	/// en: 'Participate in the EvntTrackr beta.'
	String get achievements_pioneerDescription => 'Participate in the EvntTrackr beta.';

	/// en: 'The Regular'
	String get achievements_venueRegular => 'The Regular';

	/// en: 'Attend 5 events at the same venue.'
	String get achievements_venueRegularDescription => 'Attend 5 events at the same venue.';

	/// en: 'Venue Pillar'
	String get achievements_venuePillar => 'Venue Pillar';

	/// en: 'Attend 10 events at the same venue'
	String get achievements_venuePillarDescription => 'Attend 10 events at the same venue';

	/// en: 'Venue Legend'
	String get achievements_venueLegend => 'Venue Legend';

	/// en: 'Attend 15 events at the same venue'
	String get achievements_venueLegendDescription => 'Attend 15 events at the same venue';

	/// en: 'Common'
	String get rarity_common => 'Common';

	/// en: 'Uncommon'
	String get rarity_uncommon => 'Uncommon';

	/// en: 'Rare'
	String get rarity_rare => 'Rare';

	/// en: 'Epic'
	String get rarity_epic => 'Epic';

	/// en: 'Legendary'
	String get rarity_legendary => 'Legendary';
}

// Path: artists
class TranslationsArtistsEn {
	TranslationsArtistsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Artist'
	String get artist => 'Artist';

	/// en: 'Artists'
	String get artists => 'Artists';

	/// en: 'Add artist'
	String get addArtist => 'Add artist';

	/// en: 'View artist'
	String get viewArtist => 'View artist';

	/// en: 'Rate artist'
	String get rateArtist => 'Rate artist';

	/// en: 'Performance'
	String get performanceRating => 'Performance';

	/// en: 'Setlist'
	String get setlistRatingLabel => 'Setlist';

	/// en: 'Sound Quality'
	String get soundQualityRating => 'Sound Quality';

	/// en: 'Global Review'
	String get globalReview => 'Global Review';

	/// en: 'No artists for this event.'
	String get noArtistsForEvent => 'No artists for this event.';

	/// en: 'Headliner'
	String get headliner => 'Headliner';

	/// en: 'Rating saved successfully'
	String get ratingSaved => 'Rating saved successfully';

	/// en: 'Headliners'
	String get artistSortOrderHeadliner => 'Headliners';

	/// en: 'A-Z'
	String get artistSortOrderAZ => 'A-Z';

	/// en: 'Z-A'
	String get artistSortOrderZA => 'Z-A';
}

// Path: auth
class TranslationsAuthEn {
	TranslationsAuthEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Log In'
	String get signIn => 'Log In';

	/// en: 'Sign Up'
	String get signUp => 'Sign Up';

	/// en: 'I don't have an account'
	String get dontHaveAccount => 'I don\'t have an account';

	/// en: 'I already have an account'
	String get alreadyHaveAccount => 'I already have an account';

	/// en: 'Forgot Password?'
	String get forgotPassword => 'Forgot Password?';

	/// en: 'Please enter your email'
	String get pleaseEnterYourEmail => 'Please enter your email';

	/// en: 'A password reset link was sent to your email'
	String get passwordResetLinkSent => 'A password reset link was sent to your email';

	/// en: 'Email'
	String get email => 'Email';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Username'
	String get username => 'Username';

	/// en: 'Confirm Password'
	String get confirmPassword => 'Confirm Password';

	/// en: 'EvntTrackr 2.3.0 is here!'
	String get welcome => 'EvntTrackr 2.3.0 is here!';

	/// en: 'Thank you for using EvntTrackr! I am putting my heart and soul into building an app that reflects who you are as much as it reflects my passion. The app is still in the testing phase: your feedback is essential to improving it! Please feel free to share your thoughts with me via the “About” page. Enjoy exploring!'
	String get welcomedescription => 'Thank you for using EvntTrackr! I am putting my heart and soul into building an app that reflects who you are as much as it reflects my passion. The app is still in the testing phase: your feedback is essential to improving it! Please feel free to share your thoughts with me via the “About” page. Enjoy exploring!';

	/// en: 'What's New?'
	String get whatsnew => 'What\'s New?';

	/// en: 'More to come!'
	String get moretocome => 'More to come!';

	/// en: 'EvntTrackr keeps improving and bringing new ways to enjoy your events. Don't hesitate to share your feedback via the About page 💪'
	String get alwaysimproving => 'EvntTrackr keeps improving and bringing new ways to enjoy your events. Don\'t hesitate to share your feedback via the About page 💪';

	/// en: 'Let's go!'
	String get letsgo => 'Let\'s go!';

	/// en: 'Online Event Search'
	String get new1 => 'Online Event Search';

	/// en: 'Find your events even more easily with our new online search that integrates external databases!'
	String get new1description => 'Find your events even more easily with our new online search that integrates external databases!';

	/// en: 'Never miss a beat'
	String get new2 => 'Never miss a beat';

	/// en: 'Enable event reminders with new local notifications so you are always on time.'
	String get new2description => 'Enable event reminders with new local notifications so you are always on time.';

	/// en: 'A stylish profile'
	String get new3 => 'A stylish profile';

	/// en: 'Discover an improved UI for your profile, stats, and achievements pages. Better looking and clearer!'
	String get new3description => 'Discover an improved UI for your profile, stats, and achievements pages. Better looking and clearer!';

	/// en: 'I have read and accept the privacy policy'
	String get acceptPrivacyPolicy => 'I have read and accept the privacy policy';

	/// en: 'Confirmation email sent'
	String get confirmationEmailSent => 'Confirmation email sent';
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Send'
	String get send => 'Send';

	/// en: 'Close'
	String get close => 'Close';

	/// en: 'Reset'
	String get reset => 'Reset';

	/// en: 'Create'
	String get create => 'Create';

	/// en: 'Update'
	String get update => 'Update';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Add'
	String get add => 'Add';

	/// en: 'Filter my events...'
	String get search => 'Filter my events...';

	/// en: 'Today'
	String get today => 'Today';

	/// en: 'Tomorrow'
	String get tomorrow => 'Tomorrow';

	/// en: 'In {n} days'
	String inDays({required Object n}) => 'In ${n} days';

	/// en: 'From {startDate} to {endDate}'
	String dateRange({required Object startDate, required Object endDate}) => 'From ${startDate} to ${endDate}';

	/// en: 'Page {currentPage} of {totalPages}'
	String pageOutOfTotal({required Object currentPage, required Object totalPages}) => 'Page ${currentPage} of ${totalPages}';

	/// en: 'No data available'
	String get noDataAvailable => 'No data available';

	/// en: 'See all'
	String get seeAll => 'See all';

	/// en: 'Total'
	String get total => 'Total';

	/// en: '#'
	String get rank => '#';

	/// en: 'Seen'
	String get seen => 'Seen';

	/// en: 'This Year'
	String get thisYear => 'This Year';
}

// Path: errors
class TranslationsErrorsEn {
	TranslationsErrorsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Please enter a valid price.'
	String get invalidPrice => 'Please enter a valid price.';

	/// en: 'Please enter a username'
	String get pleaseEnterAUsername => 'Please enter a username';

	/// en: 'Please enter a password'
	String get pleaseEnterAPassword => 'Please enter a password';

	/// en: 'Please confirm your password'
	String get pleaseConfirmYourPassword => 'Please confirm your password';

	/// en: 'Error during login attempt.'
	String get loginerror => 'Error during login attempt.';

	/// en: 'Error creating event'
	String get eventCreateError => 'Error creating event';

	/// en: 'Error updating event'
	String get eventUpdateError => 'Error updating event';

	/// en: 'Error adding artist'
	String get artistAddError => 'Error adding artist';

	/// en: 'Error adding location'
	String get locationAddError => 'Error adding location';

	/// en: 'Error deleting event'
	String get errorDeletingEvent => 'Error deleting event';

	/// en: 'Error'
	String get error => 'Error';

	/// en: 'Error'
	String get errorDetails => 'Error';

	/// en: 'Error updating headliner status.'
	String get errorUpdatingHeadlinerStatus => 'Error updating headliner status.';

	/// en: 'Please accept the privacy policy to continue'
	String get pleaseAcceptPrivacyPolicy => 'Please accept the privacy policy to continue';

	/// en: 'Passwords do not match'
	String get passwordsDoNotMatch => 'Passwords do not match';

	/// en: 'Password must be at least 6 characters'
	String get passwordTooShort => 'Password must be at least 6 characters';

	/// en: 'Password must contain at least one uppercase letter, one lowercase letter, and one number'
	String get passwordComplexity => 'Password must contain at least one uppercase letter, one lowercase letter, and one number';

	/// en: 'Please enter a new password'
	String get pleaseEnterNewPassword => 'Please enter a new password';

	/// en: 'Name required'
	String get nameRequired => 'Name required';

	/// en: 'Please select a location'
	String get locationRequired => 'Please select a location';

	/// en: 'Date required'
	String get dateRequired => 'Date required';

	/// en: 'Required'
	String get requiredField => 'Required';

	/// en: 'Invalid number'
	String get invalidNumber => 'Invalid number';
}

// Path: events
class TranslationsEventsEn {
	TranslationsEventsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Events'
	String get events => 'Events';

	/// en: 'Event name'
	String get eventname => 'Event name';

	/// en: 'Location'
	String get location => 'Location';

	/// en: 'Start'
	String get start => 'Start';

	/// en: 'End'
	String get end => 'End';

	/// en: 'Date and time'
	String get datetime => 'Date and time';

	/// en: 'I have my ticket'
	String get gotmyticket => 'I have my ticket';

	/// en: 'Price'
	String get price => 'Price';

	/// en: 'Event type'
	String get eventtype => 'Event type';

	/// en: 'Festival'
	String get festival => 'Festival';

	/// en: 'Concert'
	String get concert => 'Concert';

	/// en: 'Create event'
	String get createevent => 'Create event';

	/// en: 'Edit event'
	String get editEvent => 'Edit event';

	/// en: 'Edit event'
	String get editevent => 'Edit event';

	/// en: 'Event created successfully!'
	String get eventCreatedSuccess => 'Event created successfully!';

	/// en: 'Event updated successfully!'
	String get eventUpdatedSuccess => 'Event updated successfully!';

	/// en: 'Event deleted successfully.'
	String get eventDeletedSuccessfully => 'Event deleted successfully.';

	/// en: 'No details found for this event.'
	String get noEventDetailsFound => 'No details found for this event.';

	/// en: 'Delete event'
	String get deleteEvent => 'Delete event';

	/// en: 'Confirm deletion'
	String get confirmDeletion => 'Confirm deletion';

	/// en: 'Are you sure you want to delete this event? This action is irreversible.'
	String get confirmDeleteEventMessage => 'Are you sure you want to delete this event? This action is irreversible.';

	/// en: 'Ongoing'
	String get event_ongoing => 'Ongoing';

	/// en: 'Upcoming'
	String get upcoming => 'Upcoming';

	/// en: 'Past'
	String get past => 'Past';

	/// en: 'Bookmarked'
	String get bookmarked => 'Bookmarked';

	/// en: 'No upcoming events.'
	String get noupcoming => 'No upcoming events.';

	/// en: 'No past events.'
	String get nopast => 'No past events.';

	/// en: 'No bookmarked events.'
	String get nobookmarked => 'No bookmarked events.';

	/// en: 'Mark as purchased?'
	String get addToUpcoming => 'Mark as purchased?';

	/// en: 'This will move the event to the 'Upcoming' tab.'
	String get addToUpcomingInfo => 'This will move the event to the \'Upcoming\' tab.';

	/// en: 'Event added to "Upcoming" list'
	String get eventAddedToUpcoming => 'Event added to "Upcoming" list';

	/// en: 'Price (€)'
	String get priceWithCurrency => 'Price (€)';

	/// en: 'Ticket Price (optional)'
	String get ticketPriceOptional => 'Ticket Price (optional)';

	/// en: 'Search for an event, an artist...'
	String get searchPlaceholder => 'Search for an event, an artist...';

	/// en: 'Around me'
	String get filterAroundMe => 'Around me';

	/// en: 'Genre'
	String get filterGenre => 'Genre';

	/// en: 'Filter by date'
	String get filterDate => 'Filter by date';

	/// en: 'Unknown location'
	String get unknownLocation => 'Unknown location';

	/// en: 'artists included'
	String get artistsIncluded => 'artists included';

	/// en: 'artist included'
	String get artistIncluded => 'artist included';

	/// en: 'No worries, you can create it manually! (Venue and artists will be suggested)'
	String get noEventDetailsFoundDesc => 'No worries, you can create it manually! (Venue and artists will be suggested)';

	/// en: 'Create manually'
	String get createManually => 'Create manually';

	/// en: 'Online search'
	String get searchOnlineTitle => 'Online search';

	/// en: 'Feature in Beta: some events might not be found.'
	String get searchBetaDesc => 'Feature in Beta: some events might not be found.';
}

// Path: notifications
class TranslationsNotificationsEn {
	TranslationsNotificationsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	List<String> get titles => [
		'Reminder!',
		'It\'s coming soon!',
		'Get ready!',
		'Upcoming event!',
	];

	/// en: '{name} is taking place in {time}. Don't forget your ticket!'
	String withTicket({required Object name, required Object time}) => '${name} is taking place in ${time}. Don\'t forget your ticket!';

	/// en: '{name} is taking place in {time}. Have you got your ticket?'
	String withoutTicket({required Object name, required Object time}) => '${name} is taking place in ${time}. Have you got your ticket?';

	/// en: 'Date: {date} • Location: {location}'
	String details({required Object date, required Object location}) => 'Date: ${date} • Location: ${location}';

	/// en: 'one week'
	String get time1Week => 'one week';

	/// en: '24 hours'
	String get time24h => '24 hours';

	/// en: 'Event Reminders'
	String get channelName => 'Event Reminders';

	/// en: 'Notifications to remind you of your upcoming events'
	String get channelDesc => 'Notifications to remind you of your upcoming events';
}

// Path: onboarding
class TranslationsOnboardingEn {
	TranslationsOnboardingEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Welcome!'
	String get welcomeTitle => 'Welcome!';

	/// en: 'Let's start by setting up your preferences for the best experience.'
	String get welcomeSubtitle => 'Let\'s start by setting up your preferences for the best experience.';

	/// en: 'Language'
	String get languageTitle => 'Language';

	/// en: 'Choose your preferred language'
	String get languageSubtitle => 'Choose your preferred language';

	/// en: 'Theme'
	String get themeTitle => 'Theme';

	/// en: 'Customize the app appearance'
	String get themeSubtitle => 'Customize the app appearance';

	/// en: 'Date Format'
	String get dateFormatTitle => 'Date Format';

	/// en: 'How do you prefer to read dates?'
	String get dateFormatSubtitle => 'How do you prefer to read dates?';

	/// en: 'All set!'
	String get readyTitle => 'All set!';

	/// en: 'You just need to log in or sign up to get started!'
	String get readySubtitle => 'You just need to log in or sign up to get started!';

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Start'
	String get start => 'Start';

	/// en: 'Back'
	String get back => 'Back';

	/// en: 'Notifications'
	String get notificationsTitle => 'Notifications';

	/// en: 'Don't miss any of your events'
	String get notificationsSubtitle => 'Don\'t miss any of your events';
}

// Path: privacy
class TranslationsPrivacyEn {
	TranslationsPrivacyEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Privacy Policy'
	String get privacyPolicy => 'Privacy Policy';

	/// en: 'Privacy Policy'
	String get privacyPolicyTitle => 'Privacy Policy';

	/// en: 'Your privacy is important to us.'
	String get privacyPolicyContent => 'Your privacy is important to us.';

	/// en: '1. Introduction'
	String get privacy_intro_title => '1. Introduction';

	/// en: 'EvntTrackr is committed to protecting your personal data in compliance with the General Data Protection Regulation (GDPR). This policy explains how we collect, use, and protect your information.'
	String get privacy_intro_body => 'EvntTrackr is committed to protecting your personal data in compliance with the General Data Protection Regulation (GDPR). This policy explains how we collect, use, and protect your information.';

	/// en: '2. Data collected'
	String get privacy_data_collected_title => '2. Data collected';

	/// en: 'To use EvntTrackr, you must create an account with an email address and password. Within the app, you can create events with a location, dates, and artists. We never collect your live location.'
	String get privacy_data_collected_body => 'To use EvntTrackr, you must create an account with an email address and password. Within the app, you can create events with a location, dates, and artists. We never collect your live location.';

	/// en: '3. Use of data'
	String get privacy_use_of_data_title => '3. Use of data';

	/// en: 'Your data is only used to provide the app’s features. We do not sell or share your data with third parties.'
	String get privacy_use_of_data_body => 'Your data is only used to provide the app’s features. We do not sell or share your data with third parties.';

	/// en: '4. User rights'
	String get privacy_user_rights_title => '4. User rights';

	/// en: 'Under GDPR, you have the following rights:'
	String get privacy_user_rights_body => 'Under GDPR, you have the following rights:';

	/// en: 'Access your data'
	String get privacy_user_rights_list1 => 'Access your data';

	/// en: 'Download your data (events, notes, ratings)'
	String get privacy_user_rights_list2 => 'Download your data (events, notes, ratings)';

	/// en: 'Delete your data or account'
	String get privacy_user_rights_list3 => 'Delete your data or account';

	/// en: 'Correct or modify your information'
	String get privacy_user_rights_list4 => 'Correct or modify your information';

	/// en: '5. Data retention'
	String get privacy_data_retention_title => '5. Data retention';

	/// en: 'Your data is retained as long as your account is active. You can delete your account at any time.'
	String get privacy_data_retention_body => 'Your data is retained as long as your account is active. You can delete your account at any time.';

	/// en: '6. Contact'
	String get privacy_contact_title => '6. Contact';

	/// en: 'For questions about your personal data, please contact us at: evnt.trackr@gmail.com'
	String get privacy_contact_body => 'For questions about your personal data, please contact us at: evnt.trackr@gmail.com';
}

// Path: profile
class TranslationsProfileEn {
	TranslationsProfileEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Profile'
	String get profile => 'Profile';

	/// en: 'Member since'
	String get memberSince => 'Member since';

	/// en: 'Events'
	String get totalEvents => 'Events';

	/// en: 'Artists'
	String get totalArtists => 'Artists';

	/// en: 'Average'
	String get averageRating => 'Average';

	/// en: 'View my stats'
	String get viewMyStats => 'View my stats';

	/// en: 'Achievements'
	String get achievements => 'Achievements';

	/// en: 'Last event'
	String get lastEvent => 'Last event';

	/// en: 'Next event'
	String get nextEvent => 'Next event';
}

// Path: settings
class TranslationsSettingsEn {
	TranslationsSettingsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get settings => 'Settings';

	/// en: 'Preferences'
	String get preferences => 'Preferences';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Date Format'
	String get dateFormat => 'Date Format';

	/// en: 'Display Mode'
	String get displayMode => 'Display Mode';

	/// en: 'Light'
	String get light => 'Light';

	/// en: 'Dark'
	String get dark => 'Dark';

	/// en: 'System'
	String get system => 'System';

	/// en: 'Account'
	String get account => 'Account';

	/// en: 'Change Password'
	String get changePassword => 'Change Password';

	/// en: 'Reset Account'
	String get resetAccount => 'Reset Account';

	/// en: 'Resetting your account will delete all your events, ratings, and achievements. This action is irreversible.'
	String get resetAccountWarning => 'Resetting your account will delete all your events, ratings, and achievements. This action is irreversible.';

	/// en: 'Delete Account'
	String get deleteAccount => 'Delete Account';

	/// en: 'Deleting your account will permanently erase all your information and you will be logged out. This action is irreversible.'
	String get deleteAccountWarning => 'Deleting your account will permanently erase all your information and you will be logged out. This action is irreversible.';

	/// en: 'New Password'
	String get newPassword => 'New Password';

	/// en: 'Confirm New Password'
	String get confirmNewPassword => 'Confirm New Password';

	/// en: 'Password changed successfully'
	String get passwordChangedSuccessfully => 'Password changed successfully';

	/// en: 'Logout'
	String get logout => 'Logout';

	/// en: 'Profile Settings'
	String get profilsettings => 'Profile Settings';

	/// en: 'Edit Profile'
	String get editprofile => 'Edit Profile';

	/// en: 'Profile updated'
	String get profileUpdated => 'Profile updated';

	/// en: 'App'
	String get app => 'App';

	/// en: 'Reminder: 1 week before'
	String get notif1WeekTitle => 'Reminder: 1 week before';

	/// en: 'Get notified 7 days before the event'
	String get notif1WeekDesc => 'Get notified 7 days before the event';

	/// en: 'Reminder: 24 hours before'
	String get notif1DayTitle => 'Reminder: 24 hours before';

	/// en: 'Get notified the day before the event'
	String get notif1DayDesc => 'Get notified the day before the event';

	/// en: 'Debug: View notifications'
	String get debugNotifTitle => 'Debug: View notifications';

	/// en: 'No scheduled notifications'
	String get debugNoNotifs => 'No scheduled notifications';

	/// en: 'Scheduled notifications'
	String get debugPending => 'Scheduled notifications';
}

// Path: stats
class TranslationsStatsEn {
	TranslationsStatsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'My Stats'
	String get myStats => 'My Stats';

	/// en: 'Shows'
	String get totalPerformances => 'Shows';

	/// en: 'Most Seen Artists'
	String get mostSeenArtists => 'Most Seen Artists';

	/// en: 'Best Performances'
	String get bestPerformances => 'Best Performances';

	/// en: 'Festivals'
	String get festivals => 'Festivals';

	/// en: 'Concerts'
	String get concerts => 'Concerts';

	/// en: 'Event Distribution'
	String get eventDistribution => 'Event Distribution';

	/// en: 'Before {minYearStr}'
	String stats_before({required Object minYearStr}) => 'Before ${minYearStr}';

	/// en: '[Statistics]'
	String get stats_email_subject => '[Statistics]';

	/// en: 'Didn't find what you were looking for?'
	String get didntFindWhatYouWereLookingFor => 'Didn\'t find what you were looking for?';

	/// en: 'Tell us'
	String get tellUs => 'Tell us';

	/// en: 'Expenses'
	String get expenses => 'Expenses';
}

// Path: update
class TranslationsUpdateEn {
	TranslationsUpdateEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Update available'
	String get updateAvailable => 'Update available';

	/// en: 'A new version ({newVersion}) is here!'
	String updateVersionReady({required Object newVersion}) => 'A new version (${newVersion}) is here!';

	/// en: 'Update the application to enjoy the latest features and security fixes.'
	String get updateDescription => 'Update the application to enjoy the latest features and security fixes.';

	/// en: 'Update now'
	String get updateNow => 'Update now';

	/// en: 'Later'
	String get updateLater => 'Later';

	/// en: 'App is up to date'
	String get appUpToDate => 'App is up to date';

	/// en: 'Check for update'
	String get checkUpdate => 'Check for update';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'about.about' => 'About',
			'about.createdBy' => 'Created by',
			'about.version' => 'Version',
			'about.versionHistory' => 'Version History',
			'about.about_intro1' => 'As a concert enthusiast, I initially created EvntTrackr for my own needs. No more spreadsheet management headaches, just a simple and centralized experience.',
			'about.about_intro2' => 'Convinced that the app could be useful to other enthusiasts, I decided to share it with you.',
			'about.about_support_title' => 'Support the development',
			'about.about_feedback_text' => 'Your feedback is precious! Feel free to share your thoughts with me:',
			'about.about_email_tooltip' => 'Send an email',
			'about.about_instagram_tooltip' => 'Follow on Instagram',
			'about.about_donation_text' => 'A small gesture for a big project. If you\'re so inclined, you can support me with a coffee! ☕',
			'about.about_kofi_button' => 'Buy me a coffee',
			'about.about_paypal_button' => 'Donate',
			'about.about_see_whatsnew' => 'See what\'s new',
			'about.rate_us' => 'Rate the app',
			'achievements.achievements_firstStep' => 'First Step',
			'achievements.achievements_firstStepDescription' => 'Log your first event.',
			'achievements.achievements_rookieCollector' => 'Rookie Collector',
			'achievements.achievements_rookieCollectorDescription' => 'Record an artist',
			'achievements.achievements_musicCritic' => 'Music Critic',
			'achievements.achievements_musicCriticDescription' => 'Coming soon',
			'achievements.achievements_curious' => 'Curious',
			'achievements.achievements_curiousDescription' => 'Visit your statistics page',
			'achievements.achievements_regular' => 'Regular',
			'achievements.achievements_regularDescription' => 'Log 10 events.',
			'achievements.achievements_pillar' => 'Pillar',
			'achievements.achievements_pillarDescription' => 'Log 25 events.',
			'achievements.achievements_headliner' => 'Headliner',
			'achievements.achievements_headlinerDescription' => 'Log 50 events.',
			'achievements.achievements_musicPokedex' => 'Music Pokedex',
			'achievements.achievements_musicPokedexDescription' => 'Attend events with 50 different artists.',
			'achievements.achievements_trueFan' => 'True Fan',
			'achievements.achievements_trueFanDescription' => 'See the same artist at 5 different events.',
			'achievements.achievements_superFan' => 'Super Fan',
			'achievements.achievements_superFanDescription' => 'See the same artist at 10 different events.',
			'achievements.achievements_dieHardFan' => 'Die-Hard Fan',
			'achievements.achievements_dieHardFanDescription' => 'See the same artist at 15 different events.',
			'achievements.achievements_loyal' => 'Loyal',
			'achievements.achievements_loyalDescription' => 'Coming soon',
			'achievements.achievements_marathoner' => 'Marathoner',
			'achievements.achievements_marathonerDescription' => 'Coming soon',
			'achievements.achievements_eclectic' => 'Eclectic',
			'achievements.achievements_eclecticDescription' => 'Attend a concert and a festival.',
			'achievements.achievements_discoverer' => 'Discoverer',
			'achievements.achievements_discovererDescription' => 'Coming soon',
			'achievements.achievements_globetrotter' => 'Globetrotter',
			'achievements.achievements_globetrotterDescription' => 'Attend events in at least 5 different locations.',
			'achievements.achievements_archaeologist' => 'Archaeologist',
			'achievements.achievements_archaeologistDescription' => 'Log an event from more than 5 years ago.',
			'achievements.achievements_nightOwl' => 'Night Owl',
			'achievements.achievements_nightOwlDescription' => 'Record an event between 12 AM and 6 AM',
			'achievements.achievements_oops' => 'Oops',
			'achievements.achievements_oopsDescription' => 'Delete an event.',
			'achievements.achievements_summerFest' => 'Summer Fest',
			'achievements.achievements_summerFestDescription' => 'Coming soon',
			'achievements.achievements_liveLegend' => 'Live Legend',
			'achievements.achievements_liveLegendDescription' => 'Log 100 events.',
			'achievements.achievements_pioneer' => 'Pioneer',
			'achievements.achievements_pioneerDescription' => 'Participate in the EvntTrackr beta.',
			'achievements.achievements_venueRegular' => 'The Regular',
			'achievements.achievements_venueRegularDescription' => 'Attend 5 events at the same venue.',
			'achievements.achievements_venuePillar' => 'Venue Pillar',
			'achievements.achievements_venuePillarDescription' => 'Attend 10 events at the same venue',
			'achievements.achievements_venueLegend' => 'Venue Legend',
			'achievements.achievements_venueLegendDescription' => 'Attend 15 events at the same venue',
			'achievements.rarity_common' => 'Common',
			'achievements.rarity_uncommon' => 'Uncommon',
			'achievements.rarity_rare' => 'Rare',
			'achievements.rarity_epic' => 'Epic',
			'achievements.rarity_legendary' => 'Legendary',
			'artists.artist' => 'Artist',
			'artists.artists' => 'Artists',
			'artists.addArtist' => 'Add artist',
			'artists.viewArtist' => 'View artist',
			'artists.rateArtist' => 'Rate artist',
			'artists.performanceRating' => 'Performance',
			'artists.setlistRatingLabel' => 'Setlist',
			'artists.soundQualityRating' => 'Sound Quality',
			'artists.globalReview' => 'Global Review',
			'artists.noArtistsForEvent' => 'No artists for this event.',
			'artists.headliner' => 'Headliner',
			'artists.ratingSaved' => 'Rating saved successfully',
			'artists.artistSortOrderHeadliner' => 'Headliners',
			'artists.artistSortOrderAZ' => 'A-Z',
			'artists.artistSortOrderZA' => 'Z-A',
			'auth.signIn' => 'Log In',
			'auth.signUp' => 'Sign Up',
			'auth.dontHaveAccount' => 'I don\'t have an account',
			'auth.alreadyHaveAccount' => 'I already have an account',
			'auth.forgotPassword' => 'Forgot Password?',
			'auth.pleaseEnterYourEmail' => 'Please enter your email',
			'auth.passwordResetLinkSent' => 'A password reset link was sent to your email',
			'auth.email' => 'Email',
			'auth.password' => 'Password',
			'auth.username' => 'Username',
			'auth.confirmPassword' => 'Confirm Password',
			'auth.welcome' => 'EvntTrackr 2.3.0 is here!',
			'auth.welcomedescription' => 'Thank you for using EvntTrackr! I am putting my heart and soul into building an app that reflects who you are as much as it reflects my passion. The app is still in the testing phase: your feedback is essential to improving it! Please feel free to share your thoughts with me via the “About” page. Enjoy exploring!',
			'auth.whatsnew' => 'What\'s New?',
			'auth.moretocome' => 'More to come!',
			'auth.alwaysimproving' => 'EvntTrackr keeps improving and bringing new ways to enjoy your events. Don\'t hesitate to share your feedback via the About page 💪',
			'auth.letsgo' => 'Let\'s go!',
			'auth.new1' => 'Online Event Search',
			'auth.new1description' => 'Find your events even more easily with our new online search that integrates external databases!',
			'auth.new2' => 'Never miss a beat',
			'auth.new2description' => 'Enable event reminders with new local notifications so you are always on time.',
			'auth.new3' => 'A stylish profile',
			'auth.new3description' => 'Discover an improved UI for your profile, stats, and achievements pages. Better looking and clearer!',
			'auth.acceptPrivacyPolicy' => 'I have read and accept the privacy policy',
			'auth.confirmationEmailSent' => 'Confirmation email sent',
			'common.cancel' => 'Cancel',
			'common.send' => 'Send',
			'common.close' => 'Close',
			'common.reset' => 'Reset',
			'common.create' => 'Create',
			'common.update' => 'Update',
			'common.save' => 'Save',
			'common.delete' => 'Delete',
			'common.next' => 'Next',
			'common.add' => 'Add',
			'common.search' => 'Filter my events...',
			'common.today' => 'Today',
			'common.tomorrow' => 'Tomorrow',
			'common.inDays' => ({required Object n}) => 'In ${n} days',
			'common.dateRange' => ({required Object startDate, required Object endDate}) => 'From ${startDate} to ${endDate}',
			'common.pageOutOfTotal' => ({required Object currentPage, required Object totalPages}) => 'Page ${currentPage} of ${totalPages}',
			'common.noDataAvailable' => 'No data available',
			'common.seeAll' => 'See all',
			'common.total' => 'Total',
			'common.rank' => '#',
			'common.seen' => 'Seen',
			'common.thisYear' => 'This Year',
			'errors.invalidPrice' => 'Please enter a valid price.',
			'errors.pleaseEnterAUsername' => 'Please enter a username',
			'errors.pleaseEnterAPassword' => 'Please enter a password',
			'errors.pleaseConfirmYourPassword' => 'Please confirm your password',
			'errors.loginerror' => 'Error during login attempt.',
			'errors.eventCreateError' => 'Error creating event',
			'errors.eventUpdateError' => 'Error updating event',
			'errors.artistAddError' => 'Error adding artist',
			'errors.locationAddError' => 'Error adding location',
			'errors.errorDeletingEvent' => 'Error deleting event',
			'errors.error' => 'Error',
			'errors.errorDetails' => 'Error',
			'errors.errorUpdatingHeadlinerStatus' => 'Error updating headliner status.',
			'errors.pleaseAcceptPrivacyPolicy' => 'Please accept the privacy policy to continue',
			'errors.passwordsDoNotMatch' => 'Passwords do not match',
			'errors.passwordTooShort' => 'Password must be at least 6 characters',
			'errors.passwordComplexity' => 'Password must contain at least one uppercase letter, one lowercase letter, and one number',
			'errors.pleaseEnterNewPassword' => 'Please enter a new password',
			'errors.nameRequired' => 'Name required',
			'errors.locationRequired' => 'Please select a location',
			'errors.dateRequired' => 'Date required',
			'errors.requiredField' => 'Required',
			'errors.invalidNumber' => 'Invalid number',
			'events.events' => 'Events',
			'events.eventname' => 'Event name',
			'events.location' => 'Location',
			'events.start' => 'Start',
			'events.end' => 'End',
			'events.datetime' => 'Date and time',
			'events.gotmyticket' => 'I have my ticket',
			'events.price' => 'Price',
			'events.eventtype' => 'Event type',
			'events.festival' => 'Festival',
			'events.concert' => 'Concert',
			'events.createevent' => 'Create event',
			'events.editEvent' => 'Edit event',
			'events.editevent' => 'Edit event',
			'events.eventCreatedSuccess' => 'Event created successfully!',
			'events.eventUpdatedSuccess' => 'Event updated successfully!',
			'events.eventDeletedSuccessfully' => 'Event deleted successfully.',
			'events.noEventDetailsFound' => 'No details found for this event.',
			'events.deleteEvent' => 'Delete event',
			'events.confirmDeletion' => 'Confirm deletion',
			'events.confirmDeleteEventMessage' => 'Are you sure you want to delete this event? This action is irreversible.',
			'events.event_ongoing' => 'Ongoing',
			'events.upcoming' => 'Upcoming',
			'events.past' => 'Past',
			'events.bookmarked' => 'Bookmarked',
			'events.noupcoming' => 'No upcoming events.',
			'events.nopast' => 'No past events.',
			'events.nobookmarked' => 'No bookmarked events.',
			'events.addToUpcoming' => 'Mark as purchased?',
			'events.addToUpcomingInfo' => 'This will move the event to the \'Upcoming\' tab.',
			'events.eventAddedToUpcoming' => 'Event added to "Upcoming" list',
			'events.priceWithCurrency' => 'Price (€)',
			'events.ticketPriceOptional' => 'Ticket Price (optional)',
			'events.searchPlaceholder' => 'Search for an event, an artist...',
			'events.filterAroundMe' => 'Around me',
			'events.filterGenre' => 'Genre',
			'events.filterDate' => 'Filter by date',
			'events.unknownLocation' => 'Unknown location',
			'events.artistsIncluded' => 'artists included',
			'events.artistIncluded' => 'artist included',
			'events.noEventDetailsFoundDesc' => 'No worries, you can create it manually! (Venue and artists will be suggested)',
			'events.createManually' => 'Create manually',
			'events.searchOnlineTitle' => 'Online search',
			'events.searchBetaDesc' => 'Feature in Beta: some events might not be found.',
			'notifications.titles.0' => 'Reminder!',
			'notifications.titles.1' => 'It\'s coming soon!',
			'notifications.titles.2' => 'Get ready!',
			'notifications.titles.3' => 'Upcoming event!',
			'notifications.withTicket' => ({required Object name, required Object time}) => '${name} is taking place in ${time}. Don\'t forget your ticket!',
			'notifications.withoutTicket' => ({required Object name, required Object time}) => '${name} is taking place in ${time}. Have you got your ticket?',
			'notifications.details' => ({required Object date, required Object location}) => 'Date: ${date} • Location: ${location}',
			'notifications.time1Week' => 'one week',
			'notifications.time24h' => '24 hours',
			'notifications.channelName' => 'Event Reminders',
			'notifications.channelDesc' => 'Notifications to remind you of your upcoming events',
			'onboarding.welcomeTitle' => 'Welcome!',
			'onboarding.welcomeSubtitle' => 'Let\'s start by setting up your preferences for the best experience.',
			'onboarding.languageTitle' => 'Language',
			'onboarding.languageSubtitle' => 'Choose your preferred language',
			'onboarding.themeTitle' => 'Theme',
			'onboarding.themeSubtitle' => 'Customize the app appearance',
			'onboarding.dateFormatTitle' => 'Date Format',
			'onboarding.dateFormatSubtitle' => 'How do you prefer to read dates?',
			'onboarding.readyTitle' => 'All set!',
			'onboarding.readySubtitle' => 'You just need to log in or sign up to get started!',
			'onboarding.next' => 'Next',
			'onboarding.start' => 'Start',
			'onboarding.back' => 'Back',
			'onboarding.notificationsTitle' => 'Notifications',
			'onboarding.notificationsSubtitle' => 'Don\'t miss any of your events',
			'privacy.privacyPolicy' => 'Privacy Policy',
			'privacy.privacyPolicyTitle' => 'Privacy Policy',
			'privacy.privacyPolicyContent' => 'Your privacy is important to us.',
			'privacy.privacy_intro_title' => '1. Introduction',
			'privacy.privacy_intro_body' => 'EvntTrackr is committed to protecting your personal data in compliance with the General Data Protection Regulation (GDPR). This policy explains how we collect, use, and protect your information.',
			'privacy.privacy_data_collected_title' => '2. Data collected',
			'privacy.privacy_data_collected_body' => 'To use EvntTrackr, you must create an account with an email address and password. Within the app, you can create events with a location, dates, and artists. We never collect your live location.',
			'privacy.privacy_use_of_data_title' => '3. Use of data',
			'privacy.privacy_use_of_data_body' => 'Your data is only used to provide the app’s features. We do not sell or share your data with third parties.',
			'privacy.privacy_user_rights_title' => '4. User rights',
			'privacy.privacy_user_rights_body' => 'Under GDPR, you have the following rights:',
			'privacy.privacy_user_rights_list1' => 'Access your data',
			'privacy.privacy_user_rights_list2' => 'Download your data (events, notes, ratings)',
			'privacy.privacy_user_rights_list3' => 'Delete your data or account',
			'privacy.privacy_user_rights_list4' => 'Correct or modify your information',
			'privacy.privacy_data_retention_title' => '5. Data retention',
			'privacy.privacy_data_retention_body' => 'Your data is retained as long as your account is active. You can delete your account at any time.',
			'privacy.privacy_contact_title' => '6. Contact',
			'privacy.privacy_contact_body' => 'For questions about your personal data, please contact us at: evnt.trackr@gmail.com',
			'profile.profile' => 'Profile',
			'profile.memberSince' => 'Member since',
			'profile.totalEvents' => 'Events',
			'profile.totalArtists' => 'Artists',
			'profile.averageRating' => 'Average',
			'profile.viewMyStats' => 'View my stats',
			'profile.achievements' => 'Achievements',
			'profile.lastEvent' => 'Last event',
			'profile.nextEvent' => 'Next event',
			'settings.settings' => 'Settings',
			'settings.preferences' => 'Preferences',
			'settings.language' => 'Language',
			'settings.dateFormat' => 'Date Format',
			'settings.displayMode' => 'Display Mode',
			'settings.light' => 'Light',
			'settings.dark' => 'Dark',
			'settings.system' => 'System',
			'settings.account' => 'Account',
			'settings.changePassword' => 'Change Password',
			'settings.resetAccount' => 'Reset Account',
			'settings.resetAccountWarning' => 'Resetting your account will delete all your events, ratings, and achievements. This action is irreversible.',
			'settings.deleteAccount' => 'Delete Account',
			'settings.deleteAccountWarning' => 'Deleting your account will permanently erase all your information and you will be logged out. This action is irreversible.',
			'settings.newPassword' => 'New Password',
			'settings.confirmNewPassword' => 'Confirm New Password',
			'settings.passwordChangedSuccessfully' => 'Password changed successfully',
			'settings.logout' => 'Logout',
			'settings.profilsettings' => 'Profile Settings',
			'settings.editprofile' => 'Edit Profile',
			'settings.profileUpdated' => 'Profile updated',
			'settings.app' => 'App',
			'settings.notif1WeekTitle' => 'Reminder: 1 week before',
			'settings.notif1WeekDesc' => 'Get notified 7 days before the event',
			'settings.notif1DayTitle' => 'Reminder: 24 hours before',
			'settings.notif1DayDesc' => 'Get notified the day before the event',
			'settings.debugNotifTitle' => 'Debug: View notifications',
			'settings.debugNoNotifs' => 'No scheduled notifications',
			'settings.debugPending' => 'Scheduled notifications',
			'stats.myStats' => 'My Stats',
			'stats.totalPerformances' => 'Shows',
			'stats.mostSeenArtists' => 'Most Seen Artists',
			'stats.bestPerformances' => 'Best Performances',
			'stats.festivals' => 'Festivals',
			'stats.concerts' => 'Concerts',
			'stats.eventDistribution' => 'Event Distribution',
			'stats.stats_before' => ({required Object minYearStr}) => 'Before ${minYearStr}',
			'stats.stats_email_subject' => '[Statistics]',
			'stats.didntFindWhatYouWereLookingFor' => 'Didn\'t find what you were looking for?',
			'stats.tellUs' => 'Tell us',
			'stats.expenses' => 'Expenses',
			'update.updateAvailable' => 'Update available',
			'update.updateVersionReady' => ({required Object newVersion}) => 'A new version (${newVersion}) is here!',
			'update.updateDescription' => 'Update the application to enjoy the latest features and security fixes.',
			'update.updateNow' => 'Update now',
			'update.updateLater' => 'Later',
			'update.appUpToDate' => 'App is up to date',
			'update.checkUpdate' => 'Check for update',
			_ => null,
		};
	}
}
