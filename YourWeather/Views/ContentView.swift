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
// Sjekke om alt på oppgave 1 er løst
// Wrappe WeatherViewModel i en gruppemappe
// Gå til neste oppgave hvis alt på oppgaven er løst

// Lage routeren og tapgesture til knappene i bunnen Oppgave 2

// Ting som kan vente:
// Refakturerer WeatherViewModel properties

struct ContentView: View {
    @ObservedObject var weatherVM = WeatherViewModel()
    @ObservedObject var router = Router()
    @ObservedObject var locationManager = LocationManager()

    init() {
        weatherVM.fetchWeatherSymbolInfo()
        weatherVM.fetchWeatherData()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                NavigationView {
                    VStack {
                        if self.router.currentView == "detail" {
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
                                            Image("\(weatherVM.iconImage)")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 35, height: 35)
                                                .padding(.trailing, 20)
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
                                            Image("\(weatherVM.iconImage)")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 35, height: 35)
                                                .padding(.trailing, 20)
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
                                            Image("\(weatherVM.iconImage)")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 35, height: 35)
                                                .padding(.trailing, 20)
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
                        } else if self.router.currentView == "kart" {
                            MapView()
                                .navigationBarTitle("Kart", displayMode: .inline)
                        }
                    }
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
                            self.router.currentView = "kart"
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
