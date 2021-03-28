<?xml version="1.0" encoding="utf-8" ?><Configuration>    <ViewDefinitions>

        <View>
            <Name>DiskInfo</Name>
            <ViewSelectedBy>
                <TypeName>Toolmaking.DiskInfo</TypeName>
            </ViewSelectedBy>

            <TableControl>
                <TableHeaders>

                    <TableColumnHeader>
                        <Label>Host</Label>
                        <Width>16</Width>
                    </TableColumnHeader>

                    <TableColumnHeader>
                        <Label>DC</Label>
                        <Width>16</Width>
                    </TableColumnHeader>

                    <TableColumnHeader>
                        <Label>Model</Label>
                    </TableColumnHeader>

                    <TableColumnHeader>
                        <Label>RAM</Label>
                        <Alignment>Right</Alignment>
                    </TableColumnHeader>

                </TableHeaders>

                <TableRowEntries>
                    <TableRowEntry>
                        <TableColumnItems>

                            <TableColumnItem>
                                <PropertyName>ComputerName</PropertyName>
                            </TableColumnItem>

                            <TableColumnItem>
                                <PropertyName>DomainController</PropertyName>
                            </TableColumnItem>

                            <TableColumnItem>
                                <PropertyName>Model</PropertyName>
                            </TableColumnItem>

                            <TableColumnItem>
                                <PropertyName>TotalPhysicalMemory</PropertyName>
                            </TableColumnItem>

                        </TableColumnItems>
                    </TableRowEntry>
                 </TableRowEntries>
            </TableControl>
        </View>   
    </ViewDefinitions></Configuration>