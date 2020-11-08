//
//  ContentView.swift
//  ActionSheetCheckBoxes
//
//  Created by Maxim Macari on 08/11/2020.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        
        Home()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    @State var cordinate = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.4167, longitude: -3.70325), latitudinalMeters: 10000, longitudinalMeters: 10000)
    
    @State var filters = [
        FilterItem(title: "Most relevant", checked: false),
        FilterItem(title: "Top rated", checked: false),
        FilterItem(title: "Lowest price", checked: false),
        FilterItem(title: "Highest price", checked: false),
        FilterItem(title: "Most favourite", checked: false),
        FilterItem(title: "Available now", checked: false)
    ]
    
    @State var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var showFilter = false
    
    var body: some View{
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
            
            Map(coordinateRegion: $cordinate)
                .ignoresSafeArea()
            
            
            //Filter
            Button(action: {
                withAnimation {
                    showFilter.toggle()
                }
            }, label: {
                
                Image(systemName: "slider.vertical.3")
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: -5, y: -5)
                
            })
            .padding(.trailing)
            .padding(.top, 10)
            
            //Filter or Radio Button view
            
            VStack{
                Spacer()
                
                VStack(spacing: 18){
                    HStack(){
                        Text("Search by: ")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation{
                                showFilter.toggle()
                            }
                        }, label: {
                            Text("Done")
                                .fontWeight(.heavy)
                                .foregroundColor(Color.green)
                        })
                    }
                    .padding([.horizontal, .top])
                    .padding(.bottom, 10)
                    
                    ForEach(filters) { filter in
                        
                        CardView(filter: filter)
                        
                    }
                }
                .padding(.bottom, 10)
                .padding(.bottom, edges?.bottom)
                .padding(.top, 10)
                .background(Color.white.clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: showFilter ? 0 : UIScreen.main.bounds.height / 2)
            }
            .ignoresSafeArea()
            .background(
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .opacity(showFilter ? 1 : 0)
                    .onTapGesture(perform: {
                        withAnimation{
                            showFilter.toggle()
                        }
                    })
            )
            
        })
    }
}

struct CustomCorner: Shape {
    
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 35, height: 35))
        
        return Path(path.cgPath)
    }
    
}

//Card View
struct CardView: View {
    
    @State var filter: FilterItem
    
    var body: some View{
        HStack{
            Text(filter.title)
                .fontWeight(.semibold)
                .foregroundColor(Color.black.opacity(0.7))
            
            Spacer()
            
            ZStack{
                Circle()
                    .stroke(filter.checked ? Color.green : Color.gray, lineWidth: 1)
                    .frame(width: 25, height: 25)
                
                if filter.checked {
                    
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 25))
                        .foregroundColor(Color.green)
                    
                }
                
            }
        }
        .padding(.horizontal)
        .contentShape(Rectangle())
        .onTapGesture(perform: {
            filter.checked.toggle()
        })
    }
}


//data
struct FilterItem: Identifiable {
    var id = UUID().uuidString
    var title: String
    var checked: Bool
}


