import {
    Platform,
    Text,
    View,
    StyleSheet,
    TouchableOpacity
} from "react-native";

import common from "../style/common";

/*import {
    AppleMaps,
    GoogleMaps
} from "expo-maps";*/

export default function mapscreen() {
    function updateLocation() {
        return;
    }

    let mapView;

    /*if (Platform.OS === "ios") {
        mapView = <AppleMaps.View style={{ flex: 1 }} />
    }
    else if (Platform.OS === "android") {
        mapView = <GoogleMaps.View style={{ flex: 1 }} />
    }
    else {
        mapView = <Text>Maps are only available on Android and iOS</Text>
    }*/

    mapView = <Text style={common.standardText}>Map is under development. Check back later!</Text>
    return (
        <View style={common.container}>
            <View>
                <Text style={common.headerText}>Map View</Text>
            </View>
            <View>
                <Text style={common.standardText}>Latitude: </Text>
                <Text style={common.standardText}>Longitude: </Text>
                <Text style={common.standardText}>Location: </Text>
                <TouchableOpacity
                    onPress={() => updateLocation()}
                    >
                    <Text style={common.standardText}>Update</Text>
                </TouchableOpacity>
            </View>
            <View>
                {mapView}
            </View>
        </View>

    );
}

const styles = StyleSheet.create({
    standardText: {
            fontSize: 20,
            color: "#eeeeee",
    },
});