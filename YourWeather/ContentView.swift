//
//  ContentView.swift
//  YourWeather
//
//  Created by Kjetil Skylstad Bjelldokken on 26/10/2020.
//

import Combine
import SwiftUI

// Hva trengs å gjøres i neste steg:
// Skrive Readme fila!
// Sjekke om alt på oppgave 1 er løst
// Wrappe WeatherViewModel i en gruppemappe
// Gå til neste oppgave hvis alt på oppgaven er løst

// Lage routeren og tapgesture til knappene i bunnen Oppgave 2

// Ting som kan vente:
// Refakturerer WeatherViewModel properties

struct ContentView: View {
    @ObservedObject var weatherVM = WeatherViewModel()

    init() {
        weatherVM.fetchWeatherSymbolInfo()
        weatherVM.fetchWeatherData()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                NavigationView {
                    VStack {
                        List(){
                            Section(header: Text("Nå")) {
                                VStack() {
                                    HStack{
                                        Text("Temperatur")
                                        Spacer()
                                        Text("\(weatherVM.instantTemperature, specifier: "%.1f")")
                                            .padding()
                                        Text("\(weatherVM.instantText)")
                                    }
                                }.frame(height: 60)
                            }
                            
                            Section(header: Text("Neste time")) {
                                VStack{
                                    HStack{
                                        Text("Vær")
                                        Spacer()
                                        VStack{
                                            Text("\(weatherVM.nextHourSummary)")
                                                .padding(.bottom, 0.5)
                                            HStack {
                                                Text("\(weatherVM.nextHourDetails, specifier: "%.1f")")
                                                Text("\(weatherVM.nextHourPrecipitationText)")
                                            }
                                        }
                                    }
                                }.frame(height: 60)
                            }
                            
                            Section(header: Text("Neste 6 timer")) {
                                VStack{
                                    HStack{
                                        Text("Vær")
                                        Spacer()
                                        VStack{
                                            Text("\(weatherVM.next6HourSummary)")
                                                .padding(.bottom, 0.5)
                                            HStack{
                                                Text("\(weatherVM.next6HourDetails, specifier: "%.1f")")
                                                Text("\(weatherVM.next6HourPrecipitationText)")
                                            }
                                        }
                                    }
                                }.frame(height: 60)
                            }
                            
                            Section(header: Text("Neste 12 timer")) {
                                VStack{
                                    HStack{
                                        Text("Vær")
                                        Spacer()
                                        VStack{
                                            Text("\(weatherVM.next12HorsSummary)")
                                                .padding(.bottom, 0.5)
                                        }
                                    }
                                }.frame(height: 60)
                            }
                            
                        }.environment(\.defaultMinListRowHeight, 60)
                        .navigationBarTitle("Værmelding")                // Finnes det noen navigationBarBottom eller lignende
                        .navigationBarItems(trailing: Button(action: {
                            weatherVM.fetchWeatherData()
                            weatherVM.fetchWeatherSymbolInfo()
                        }, label: {
                            Text("Refresh")
                        }))
                    }
                    
                    // Se på om det går ann å bruke navbar bottom..
                    //VStack{
                }
                Spacer()
                Divider()
                HStack{ // Disse dataene må hentes inn! og justee skriftstørrelsen
                    Text("Høyskolen Kristiania")
                        .padding(.leading)
                    Spacer()
                    Text("59.911166, 10.744810")
                        .padding(.trailing)
                }
                Divider()
                // Maid a custom tab bar
                HStack {
                    //Button(action: {}) {
                    Text("Værmelding")
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .onTapGesture {
                            //Trenger å implementere denne med routeren
                        }
                    //}
                    //.background(Color.gray)
                    //.foregroundColor(.black)
                    //.cornerRadius(10)
                    Divider()
                    
                    Text("Kart")
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .onTapGesture {
                            //Trenger å implementere denne med routeren
                        }
                    /*
                    Button("Kart") {
                        
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.gray)
                    .foregroundColor(.black)
                    .cornerRadius(10) */
                }.frame(width: geometry.size.width, height: geometry.size.height/15)
                
                
                //.frame(width: UIScreen.main.bounds.width - 10,height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                //.background(Color.white)
            
                // }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
