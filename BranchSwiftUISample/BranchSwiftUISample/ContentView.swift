//
//  ContentView.swift
//  BranchSwiftUISample
//
//  Created by Nipun Singh on 11/1/23.
//

import SwiftUI
import BranchSDK

struct ContentView: View {
    @State private var branchLink = ""
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @State private var showQRPopover = false
    @State private var qrCodeImage: UIImage?
        
    @State private var isTrackingDisabled = Branch.trackingDisabled()

    var body: some View {
        NavigationView {
            List {
                TextField("Create Branch Link", text: $branchLink)
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .textFieldStyle(PlainTextFieldStyle())
                    .background(Color.clear)
                
                Button(action: createLink) {
                    Label("Create Branch Link", systemImage: "link")
                        .foregroundColor(.blue)
                        .font(.system(size: 19, weight: .medium, design: .rounded))
                }
                
                Button(action: shareLink) {
                    Label("Share Branch Link", systemImage: "square.and.arrow.up")
                        .foregroundColor(.blue)
                        .font(.system(size: 19, weight: .medium, design: .rounded))
                }
                Button(action: createQRCode) {
                    Label("Create QR Code", systemImage: "qrcode")
                        .foregroundColor(.blue)
                        .font(.system(size: 19, weight: .medium, design: .rounded))
                }
                Button(action: sendEvent) {
                    Label("Send Branch Event", systemImage: "paperplane.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 19, weight: .medium, design: .rounded))
                }
                Button(action: toggleTracking) {
                    Label("\(isTrackingDisabled ? "Enable" : "Disable") Tracking", systemImage: isTrackingDisabled ? "eye" : "eye.slash")
                        .foregroundColor(.blue)
                        .font(.system(size: 19, weight: .medium, design: .rounded))
                }
                Button(action: setIdentity) {
                    Label("Set Identity", systemImage: "person.crop.circle")
                        .foregroundColor(.blue)
                        .font(.system(size: 19, weight: .medium, design: .rounded))
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Branch Sample App")
        }
        .environment(\.defaultMinListRowHeight, 50)
        .popover(isPresented: $showQRPopover, arrowEdge: .top) {
            VStack {
                Text("Your QR Code")
                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                Image(uiImage: (qrCodeImage ?? UIImage(systemName: "qrcode"))!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
            }
            .padding()
        }
        .id(qrCodeImage?.hashValue ?? 0)
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    func createLink() {
        print("createLink() tapped")
        let buo = BranchUniversalObject(canonicalIdentifier: "sampleBuo/123")
        let lp = BranchLinkProperties()
        
        buo.getShortUrl(with: lp) { url, error in
            branchLink = url ?? ""
        }
    }
    
    func shareLink() {
        let buo = BranchUniversalObject(canonicalIdentifier: "sampleBuo/123")
        
        buo.showShareSheet(withShareText: "Share this link!") { activityType, completed in
            if completed {
                print("Shared to \(activityType ?? "?")")
            }
        }
    }
    
    func sendEvent() {
        let event = BranchEvent.standardEvent(.addToCart)
        event.logEvent { success, error in
            if error != nil {
                print(error as Any)
                return
            }
            
            alertTitle = "Event Sent"
            alertMessage = "Add To Cart event was sent."
            showingAlert = true
        }
    }
    
    func toggleTracking() {
        Branch.setTrackingDisabled(!isTrackingDisabled)
        isTrackingDisabled = Branch.trackingDisabled()
    }
    
    func setIdentity() {
        Branch.getInstance().setIdentity("testBranchUser") { params, error in
            if error != nil {
                print(error as Any)
                return
            }
            
            alertTitle = "Identity Set"
            alertMessage = "Identity was set to testBranchUser"
            showingAlert = true
        }
    }
    
    func createQRCode() {
        let buo = BranchUniversalObject(canonicalIdentifier: "sampleBuo/123")
        let lp = BranchLinkProperties()
        let qrCode = BranchQRCode()
        qrCode.codeColor = UIColor.white
        qrCode.backgroundColor = UIColor.blue
        qrCode.centerLogo = "https://i.snipboard.io/nshJlY.jpg"
        qrCode.width = 350
        qrCode.margin = 0
        qrCode.imageFormat = .JPEG
        
        qrCode.getAsImage(buo, linkProperties: lp) { image, error in
            if (error != nil) {
                print(error as Any)
                return
            }
            
            print("Got QR Code Image!")
            DispatchQueue.main.async {
                self.qrCodeImage = image
                self.showQRPopover = true
            }
        }
    }
}

#Preview {
    ContentView()
}
