# iOS_exam for kandidatnr:     10050

## Versjons spesifikasjoner:
* Xcode versjon: 12.1
* Swift versjon: 5.3
* Skrevet i SwiftUI

## Kilder og Referanser brukt som inspirasjon
*  ObservableObject:  https://www.youtube.com/watch?v=xT4wGOc2jd4&t=660s   
* DateFormatter: https://www.hackingwithswift.com/example-code/system/how-to-convert-dates-and-times-to-a-string-using-dateformatter
* Api calls: https://www.hackingwithswift.com/books/ios-swiftui/understanding-swifts-result-type
* Footer and router: https://blckbirds.com/post/custom-tab-bar-in-swiftui/
* LocationManager: https://medium.com/@kiransjadhav111/corelocation-map-kit-get-the-users-current-location-set-a-pin-in-swift-edb12f9166b2
* For å bruke UIViewRepresentable: https://www.hackingwithswift.com/books/ios-swiftui/advanced-mkmapview-with-swiftui

## Forutsetninger
* Dere har skrevet i oppgave 1 at "alt på eksempelbildet skal hentes fra api'et", men jeg forutsetter at det ikke gjelder de statiske ordene

## Kommentarer
* Jeg valgte SwiftUI fordi jeg syns det er bedre å kode med, og for å gi meg selv en utfordring. Jeg hadde lyst til å se om jeg kunne bygge denne appen med det jeg mener er fremtidens iOS språk.
* Når det kom til bruken av annotation for å trykke på et sted på kartet og få opp koordinater så fant jeg ut at SwiftUI ikke støtter dette (iallfall ikke som jeg kunne finne på nåværende tidspunkt). Dette tvinget meg til å bruke MKMapView fra UIKit. Men jeg fant ut at jeg kunne bruke UIViewRepresentable for å wrappe MKMapview sånn at jeg kunne bruke den i SwifUI view. Dette gjorde også at jeg kunne bruke @binding for å oppdatere coordinatverdiene i info felte når de endret seg ved trykk (longpress) på kartet.

## Utfordringer/ error jeg har møtt på underveis
* Hvis jeg kjørte koden i simulatoren rundt kl 00:00 på natten, så fikk jeg ofte en feilmelding på at self.symbolData[0] var "out of range". Jeg kunne ha sittet hele dagen og brukt simulatoren, og uten å ha gjort noen endringer kom den feilmelingen i området rundt kl 00:00. Jeg lurer på om det er noe med api'et og at de gjør noen endrigner oppdateringer rundt da. Men fikk ikke samme feilmelding da jeg kjørte på telefonen. Hvis jeg prøvde koden dagen etter på dagtid virket alt igjen uten at jeg gjorde noen endringer.
* Jeg har en issue i koden når det gjelder å display'e vær iconet i mapview når jeg går tilbake til map fra væremeldingsiden (contenview). Ikke første gang, men etterpå. Da hender det at iconet ikke vises. Hvis jeg da flytter litt på kartet så kommer det frem, så det virker som om bildet er der, bare ikke syns. Andre ganger vises det med en gang. Dette har jeg ikke rukket å finne ut av pga tidspress pga familiesituasjonen min.

