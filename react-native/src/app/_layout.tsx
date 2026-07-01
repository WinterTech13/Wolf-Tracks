import { NativeTabs } from 'expo-router/unstable-native-tabs';

export default function TabLayout() {
    return (
        <NativeTabs>
            <NativeTabs.Trigger name="screens/input">
                <NativeTabs.Trigger.Label>Data Collection</NativeTabs.Trigger.Label>
                <NativeTabs.Trigger.Icon sf="figure.walk" md="directions_walk" />
            </NativeTabs.Trigger>
            <NativeTabs.Trigger name="screens/data">
                            <NativeTabs.Trigger.Label>Pedestrian Data</NativeTabs.Trigger.Label>
                            <NativeTabs.Trigger.Icon sf="chart.bar.fill" md="bar_chart" />
            </NativeTabs.Trigger>
            <NativeTabs.Trigger name="screens/map">
                            <NativeTabs.Trigger.Label>Map</NativeTabs.Trigger.Label>
                            <NativeTabs.Trigger.Icon sf="map.fill" md="map" />
            </NativeTabs.Trigger>
            <NativeTabs.Trigger name="screens/io">
                            <NativeTabs.Trigger.Label>Import/Export</NativeTabs.Trigger.Label>
                            <NativeTabs.Trigger.Icon sf="chart.bar.doc.horizontal" md="data_table" />
            </NativeTabs.Trigger>
        </NativeTabs>
        );
    }