//
//  ContentView.swift
//  YourWeather
//
//  Created by Kjetil Skylstad Bjelldokken on 26/10/2020.
//

import Combine
import SwiftUI
import MapKit

// Ting som må følges opp underveis
// Skrive Readme fila!

// Hva trengs å gjøres i neste steg:
// Enkel værmelding som viser om det blir regn neste 12 timer
// I så fall gi beskjed om at bruker må ha med paraply.
// Ta utgangspunkt i brukers posisjon
// Hvis hvilken dag det gjelder for
// Denne info skal lagres på disk
// Easter egg. Animasjon se oppgave tekst

// Ting som må gjøres før levering:
// Kommentere hvor jeg har tatt kode fra


// Ting som kan vente:
// Sjekke opp buggen om at man må trykke 2 ganger på værmeldngs knappen i toggle modus på kart for at det skal skje noe
// Refakturerer WeatherViewModel properties

struct ContentView: View {
    @ObservedObject var weatherVM = WeatherViewModel()
    @ObservedObject var router = Router()
    @ObservedObject var locationManager = LocationManager()
    //@State var isLoaded = true

    init() {
        
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                NavigationView {
                    VStack {
                        if self.router.currentView == "home" {
                            //HomeView()
                                //.navigationBarTitle("Hjem", displayMode: .inline)
                            
                        } else if self.router.currentView == "detail" {
                            List(){
                                Section(header: Text("Nå")) {
                                    VStack() {
                                        HStack{
                                            Text("Temperatur")
                                            Spacer()
                                            Text("\(weatherVM.instantTemperature, specifier: "%.1f")")
                                                .padding()
                                            Text("\(weatherVM.instantText)")
                                                .padding(.trailing)
                                        }
                                    }.frame(height: 60)
                                    
                                }
                                
                                Section(header: Text("Neste time")) {
                                    VStack{
                                        HStack{
                                            Text("Vær")
                                            Spacer()
                                            Image("\(weatherVM.iconImageNextHour)")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 35, height: 35)
                                                .padding(.trailing, 10)
                                            VStack{
                                                Text("\(weatherVM.nextHourSummary)")
                                                    .padding(.bottom, 0.5)
                                                HStack {
                                                    Text("\(weatherVM.nextHourDetails, specifier: "%.1f")")
                                                    Text("\(weatherVM.nextHourPrecipitationText)")
                                                }
                                            }.padding(.trailing)
                                        }
                                    }.frame(height: 60)
                                }
                                
                                Section(header: Text("Neste 6 timer")) {
                                    VStack{
                                        HStack{
                                            Text("Vær")
                                            Spacer()
                                            Image("\(weatherVM.iconImageNext6Hours)")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 35, height: 35)
                                                .padding(.trailing, 10)
                                            VStack{
                                                Text("\(weatherVM.next6HourSummary)")
                                                    .padding(.bottom, 0.5)
                                                HStack{
                                                    Text("\(weatherVM.next6HourDetails, specifier: "%.1f")")
                                                    Text("\(weatherVM.next6HourPrecipitationText)")
                                                }
                                            }.padding(.trailing)
                                        }
                                    }.frame(height: 60)
                                }
                                
                                Section(header: Text("Neste 12 timer")) {
                                    VStack{
                                        HStack{
                                            Text("Vær")
                                            Spacer()
                                            Image("\(weatherVM.iconImageNext12Hours)")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 35, height: 35)
                                                .padding(.trailing, 10)
                                            VStack{
                                                Text("\(weatherVM.next12HorsSummary)")
                                                    //.padding(.bottom, 0.5)
                                            }.padding(.trailing)
                                        }
                                    }.frame(height: 60)
                                }
                            }.environment(\.defaultMinListRowHeight, 60)
                            .navigationBarTitle("Værmelding", displayMode: .inline)
                            .navigationBarItems(trailing: Button(action: {
                                weatherVM.fetchWeatherSymbolInfo()
                                weatherVM.fetchWeatherData()
                            }, label: {
                                Text("Refresh")
                            }))
                        } else if self.router.currentView == "map" {
                            MapView()
                                .navigationBarTitle("Kart", displayMode: .inline)
                            
                        }
                    }
                }.alert(item: $weatherVM.error) { error in
                    Alert(title: Text("Error"), message: Text(error.localizedDescription), dismissButton: .cancel())
                }.onAppear() {
                    weatherVM.fetchWeatherSymbolInfo()
                    weatherVM.fetchWeatherData()
                }
                Spacer()
                Divider()
                if self.router.currentView == "detail" {
                HStack{
                    Text("Din posisjon")
                        .padding(.leading)
                    Spacer()
                    VStack{
                        if lat == "59.911166" && lon == "10.744810" {
                        Text("Høyskolen Kristiania")
                            .padding(.trailing)
                        } else {
                            Text("\(lat),   \(lon)")
                            .padding(.trailing)
                        }
                    }
                }
                } else {
                    HStack{
                    }
                }
                Divider()
                // Maid a custom tab bar
                HStack {
                    Text("Hjem")
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .onTapGesture {
                            self.router.currentView = "home"
                        }
                    
                    Divider()
                    
                    Text("Værmelding")
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .onTapGesture {
                            self.router.currentView = "detail"
                            weatherVM.fetchWeatherSymbolInfo()
                            weatherVM.fetchWeatherData()
                        }
            
                    Divider()
                    
                    Text("Kart")
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .onTapGesture {
                            self.router.currentView = "map"
                        }
                }.frame(width: geometry.size.width, height: geometry.size.height/15)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
