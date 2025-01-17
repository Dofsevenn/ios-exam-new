# iOS_exam

## Versjons spesifikasjoner:
* Xcode versjon: 12.1
* Swift versjon: 5.3
* Skrevet i SwiftUI

## Innledning
* Dette har vært et veldig morsomt prosjekt, men med mye frustrasjon over at det ble lite tid til rådighet pga covid-19 situasjonen. Selv med utsatt tid på eksamen ble tiden veldig avkortet pga at barna måtte være hjemme fra barnehagen veldig ofte grunnet strenge covid-19 regler for når de får være der, samt at de voksne i barnehagen ble syke.
* Denne innledingnen er ikke ment som noen klageing eller noe, man bare for at sensor skal ha en forståelse om hvorfor jeg ikke kom lenger.

## Kilder og Referanser brukt som inspirasjon
*  ObservableObject:  https://www.youtube.com/watch?v=xT4wGOc2jd4&t=660s   
* DateFormatter: https://www.hackingwithswift.com/example-code/system/how-to-convert-dates-and-times-to-a-string-using-dateformatter
* Api calls: https://www.hackingwithswift.com/books/ios-swiftui/understanding-swifts-result-type
* Footer and router: https://blckbirds.com/post/custom-tab-bar-in-swiftui/
* LocationManager: https://medium.com/@kiransjadhav111/corelocation-map-kit-get-the-users-current-location-set-a-pin-in-swift-edb12f9166b2
* For å bruke UIViewRepresentable: https://www.youtube.com/watch?v=Ek_r-7aRp3A

## Forutsetninger
* Dere har skrevet i oppgave 1 at "alt på eksempelbildet skal hentes fra api'et", men jeg forutsetter at det ikke gjelder de statiske ordene som "Temperatur" "vær", "NÅ", "Neste time", "Neste 6 timer" og "Neste12 timer". Altså ordene som står på venstre side av skjermen på Værmeldings siden.

## Kommentarer/ Valg jeg har gjort
* Jeg valgte SwiftUI fordi jeg syns det er morsommere og bedre å kode med, og for å gi meg selv en utfordring. Jeg hadde lyst til å se om jeg kunne bygge denne appen med det jeg mener er fremtidens iOS språk. 
* Jeg har brukt State og ObservableObject for å holde styr på state og å sende data mellom classer og structs. Dette er en av de store fordelene med SwiftUI contra UIKit, og som er en av grunnene til at jeg valgte å bruke SwiftUI.
* Når det kom til bruken av annotation for å trykke på et sted på kartet og få opp koordinater så fant jeg ut at SwiftUI ikke støtter dette (iallfall ikke som jeg kunne finne på nåværende tidspunkt). Dette tvang meg til å bruke MKMapView fra UIKit. Men jeg fant ut at jeg kunne bruke UIViewRepresentable for å wrappe MKMapview sånn at jeg kunne bruke den i SwifUI view. Dette gjorde også at jeg kunne bruke @binding for å oppdatere coordinatverdiene i info felte når de endret seg ved trykk (longpress) på kartet, samt oppdatere vermeldings iconet.
* På bakgrunn av det i punktet over og at jeg bruker SwiftUI med dens muligheter med å sende og oppdatere data så så jeg ikke noe poeng for meg med å skulle bruke delegate og eget view til info delen hvor coordinatene og værmeldingen vises, slik det står i oppgaven. Et av poengene med SwiftUI er å bruke State og ObserableObject, så i dette tilfellet brukte jeg  @Binding og @State for å oppdatere infoen med coordinater og værmeldingen.
* Videre på annotation så valgte jeg å ikke bruke noen region med zoom da dette bare forstyrret opplevelsen. Sånn som jeg har det nå så kan bruker velge selv hvor nære han/hun vil zoome, og det er lettere å velge et sted i verden som er langt unna der hvor kartet starter. Og sjansen for å skulle sjekke et sted langt unna er jo stor, f.eks hvis man skal på ferie.
* Når det gjelder det oppgaven sier om at værmeldings siden skal vise Høyskolen Kristiania sin værmelding første gang man går inn der så er den logikken i koden, men da jeg satte opp hjem siden som første side og hentet inn users current location, så oppdaterer værmeldingsiden også, og man ser aldri HK sin værmelding. Jeg rakk ikke å løse dette problemet, men ser heller ikke poenget i at den skal vises hvis ikke værmelding siden skal være den først. Dette kan gjøre hvis sensor går inn i router.swift og bytter fra "home" til "detail" (må sikkert sette location godkjenningen til å spørre på nytt), for å se at logikken fra oppgave 1 og 2 fungerer.

## Utfordringer/ error jeg har møtt på underveis
* Hvis jeg kjørte koden i simulatoren rundt kl 00:00 på natten, så fikk jeg innimellom en feilmelding på at self.symbolData[0] var "out of range". Jeg kunne ha sittet hele dagen og brukt simulatoren, og uten å ha gjort noen endringer kom den feilmelingen i området rundt kl 00:00. Jeg lurer på om det er noe med api'et og at de gjør noen endrigner oppdateringer rundt da. Men fikk ikke samme feilmelding da jeg kjørte på telefonen. Hvis jeg prøvde koden dagen etter på dagtid virket alt igjen uten at jeg gjorde noen endringer.
* Jeg har en issue i koden når det gjelder å display'e vær iconet i mapview når jeg går tilbake til map fra væremeldingsiden (contenview). Ikke første gang, men etterpå. Da hender det at iconet ikke vises. Hvis jeg da flytter litt på kartet så kommer det frem, så det virker som om bildet er der, bare ikke syns. Andre ganger vises det med en gang. Dette har jeg ikke rukket å finne ut av pga tidspress pga familiesituasjonen min som nevnt i intro.
* Jeg har en bug når man er i toggle modus altså pin annotation view. Hvis man har trykket et sted på skjermen for å få værmelding der, så må man trykke 2 ganger, eller flytte litt på kartet for å kunne trykke en gang til eller på knappene. Jeg har ikke rukket å finne ut av denne feilen. 
* Når det kommer til feilmelding til bruker når api'et ikke funker så fikk jeg det til på værmelding siden, men fikk det ikke til med det første på kart siden hvor man velger værmelding selv. Der hvor jeg fikk det til så viser den en annen feilmelding enn den jeg hadde tenkt, men jeg brukte ikke tid på å rette opp i dette. Brukte heller tiden på oppgave 4 og 5. Dette grunnet situasjonen min som beskrevet i innledningen.


