import SwiftUI
import Charts




struct ChartsView: View {
    @StateObject private var viewModel = ChartsViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                Text("Step Tracking")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                // Statistics Row
                HStack(spacing: 15) {
                    StatisticsCardView(
                        title: "Average",
                        value: String(viewModel.getAverageSteps(for: viewModel.getChartData()))
                    )
                    
                    StatisticsCardView(
                        title: "Total",
                        value: String(viewModel.getTotalSteps(for: viewModel.getChartData()))
                    )
                }
                .padding(.horizontal)
                
                // Chart
                Chart {
                    ForEach(viewModel.getChartData()) { data in
                        BarMark(
                            x: .value("Date", data.date, unit: viewModel.getChartXAxisUnit()),
                            y: .value("Steps", data.count)
                        )
                    }
                }
                .foregroundColor(.green)
                .frame(height: 450)
                .padding(.horizontal)
                
                // Period Selector
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(ChartOptions.allCases, id: \.rawValue) { option in
                            Button(action: {
                                withAnimation {
                                    viewModel.selectedChartType = option
                                }
                            }) {
                                Text(option.rawValue)
                                    .foregroundColor(viewModel.selectedChartType == option ? .white : .green)
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 10)
                                    .background(viewModel.selectedChartType == option ? Color.green : Color.clear)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}


#Preview {
    ChartsView()
}
